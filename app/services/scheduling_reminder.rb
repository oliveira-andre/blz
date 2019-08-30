module SchedulingReminder
  class << Self
    def execute
      Scheduline.all.each do |scheduling|
        if scheduling.date = (Time.now.utc - 28.hours)
          SchedulingReminder.four_hours(scheduling).deliver_later
        end

        if scheduling.date = (Time.now.utc - 6.hours)
          SchedulingReminder.twenty_four_hours(scheduling).deliver_later
        end
      end
    end
  end
end