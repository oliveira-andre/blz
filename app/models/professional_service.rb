class ProfessionalService < ApplicationRecord
  belongs_to :professional
  belongs_to :service

  has_many :schedules, dependent: :destroy
  has_many :scheduling

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
end
