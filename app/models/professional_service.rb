class ProfessionalService < ApplicationRecord
  belongs_to :professional
  belongs_to :service

  has_many :schedules

  def table_schedule
    return [] if schedules.empty?

    schedules.to_a.map! do |schedule|
      dates = schedules.where(date: schedule.date.all_day).pluck(:date)
      { I18n.l(schedule.date, format: :day_month) => dates }
    end.uniq!
  end
end
