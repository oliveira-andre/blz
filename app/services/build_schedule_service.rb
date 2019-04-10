class BuildScheduleService
  class << self
    def execute(professional_service)
      @professional_service = professional_service
      @professional = professional_service.professional
      @service = professional_service.service

      professional_service.schedules.destroy_all
      generate_schedule
    end

    private

    attr_accessor :professional, :service, :professional_service, :work_at

    def generate_schedule
      (0..30).each do |day|
        @work_at = Date.today + day.days
        wday = work_at.strftime('%w').to_i
        wday_office_hours = professional.office_hours.where(week_day: wday)
        wday_office_hours.each { |office_hour| create_schedule office_hour }
      end
    end

    def create_schedule(office_hour)
      work_until = date_join_time(work_at, office_hour.hour_end)
      schedule_date_begin = date_join_time(work_at, office_hour.hour_begin)
      loop do
        schedule_date_end = schedule_date_begin + service.duration.minutes
        break unless schedule_date_valid?(schedule_date_end, work_until)
        Schedule.create!(
          date: schedule_date_begin,
          professional_service_id: professional_service.id
        )
        schedule_date_begin += service.duration.minutes
      end
    end

    def date_join_time(date, hour_int)
      (date.to_s + ' ' + hour_mask(hour_int)).to_datetime
    end

    def hour_mask(hour)
      length = hour.to_s.length
      hour.to_s.insert(length - 2, ':')
    end

    def schedule_date_valid?(data_end, work_end)
      data_end <= work_end
    end
  end
end
