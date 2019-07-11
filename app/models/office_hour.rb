class OfficeHour < ApplicationRecord
  default_scope { order(:week_day, :hour_begin) }

  belongs_to :professional
  enum week_day: {
    segunda: 1, terça: 2, quarta: 3, quinta: 4, sexta: 5, sabado: 6, domingo: 7
  }

  validates :week_day, presence: true
  validates :hour_begin, presence: true, length: { in: 1..2359 }
  validates :hour_end, presence: true, length: { in: 1..2359 }

  validate :hours_validate
  validate :during_hour_work

  after_save :rebuild_schedule
  after_destroy :rebuild_schedule
  after_destroy :verify_professional_without_hour

  private

  def during_hour_work
    if hour_end > begin_work && hour_end < end_work
      errors.add(:hour_end, 'já está sendo usada!')
    end

    if hour_begin < end_work && hour_begin > begin_work
      errors.add(:hour_begin, 'já está sendo usada!')
    end
  end

  def hours_validate
    return if hour_end > hour_begin

    errors.add(:hour_begin, 'deve ser menor do que a hora final')
  end

  def end_work
    @end_work ||= professional.office_hours
                              .where(week_day: week_day)
                              .last&.hour_end || 0
  end

  def begin_work
    @begin_work ||= professional.office_hours
                                .where(week_day: week_day)
                                .first&.hour_begin || 0
  end

  def rebuild_schedule
    Schedule.rebuild(professional)
  end

  def verify_professional_without_hour
    return if professional.office_hours.count.positive?

    services_ids = ProfessionalService.where(professional_id: professional.id)
                                      .pluck(:service_id)

    Service.where(id: services_ids).update_all(status: :awaiting_avaliation)
  end
end
