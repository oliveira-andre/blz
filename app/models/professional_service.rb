class ProfessionalService < ApplicationRecord
  belongs_to :professional
  belongs_to :service

  has_many :schedules, dependent: :destroy
  has_many :scheduling

  validate :professional_with_hours

  after_create :rebuild_schedule
  after_destroy :verify_last_professional_service

  def table_schedule
    return [] if schedules.empty?

    schedules.pluck(:date)
             .uniq { |date| date.strftime('%d/%m/%Y') }.map! do |date|

      schedule = schedules.select(:date, :free).where(date: date.all_day)
      {
        I18n.l(date, format: :day_month) => schedule
      }
    end
  end

  private

  def rebuild_schedule
    Schedule.rebuild(self)
  end

  def verify_last_professional_service
    return if service.professional_services.count.positive?

    service.awaiting_avaliation!
  end

  def professional_with_hours
    return if professional.office_hours.count.positive?

    @errors.add(:professional, 'não possui horários de trabalho cadastrado.')
  end
end
