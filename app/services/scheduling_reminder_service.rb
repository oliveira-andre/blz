# frozen_string_literal: true

module SchedulingReminderService
  class << self
    def execute
      schedulings_twenty_four_hours = Scheduling.where(
        status: :scheduled,
        date: (Time.now.utc - 28.hours)
      )

      schedulings_twenty_four_hours.each do |scheduling|
        SchedulingReminderMailer.four_hours(scheduling).deliver_later
      end

      schedulings_four_hours = Scheduling.where(
        status: :scheduled,
        date: (Time.now.utc - 6.hours)
      )

      schedulings_four_hours.each do |scheduling|
        SchedulingReminderMailer.twenty_four_hours(scheduling).deliver_later
      end
    end
  end
end
