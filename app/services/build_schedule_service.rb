class BuildScheduleService
  class << self
    def execute(professional_service)
      @professional_service = professional_service
      @professional = professional_service.professional
      @service = professional_service.service

      professional_service.schedules.destroy_all
      Date.today.step(Date.today + 30.days) { |date| schedules_to(date) }
    end

    private

    attr_accessor :professional, :service, :professional_service

    def schedules_to(date)
      professional.office_hours.where(week_day: date.cwday).each do |o_f|
        start_day = date_join_time(date, o_f.hour_begin)
        finish_day = date_join_time(date, o_f.hour_end)

        start_day.step(finish_day, duration_to_day) do |datetime|
          Schedule.create!(
            date: datetime,
            professional_service_id: professional_service.id
          )
        end
      end
    end

    def date_join_time(date, hour_int)
      hour = hour_int.to_s.insert(hour_int.to_s.length - 2, ':')
      (date.to_s + ' ' + hour).to_datetime
    end

    def duration_to_day
      duration_in_hour = service.duration.to_f / 60.0
      hour_in_day = 1.0 / 24.0

      hour_in_day * duration_in_hour
    end
  end
end
