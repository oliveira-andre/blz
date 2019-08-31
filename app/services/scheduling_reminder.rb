module SchedulingReminder
  class << self
    def execute
      schedulings = Scheduling.where(
        status: :scheduled,
        date: ((Time.now - 2.days)..Time.now)
      )
      schedulings.each do |scheduling|
        if scheduling.date == (Time.now.utc - 28.hours)
          SchedulingReminderMailer.four_hours(scheduling).deliver_later
        end

        if scheduling.date == (Time.now.utc - 6.hours)
          SchedulingReminderMailer.twenty_four_hours(scheduling).deliver_later
        end
      end
    end
  end
end