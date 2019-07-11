class BuildScheduleService
  class << self
    def execute(professional)
      @professional = professional

      professional.professional_services.each do |ps|
        ps.schedules.destroy_all
        Date.today.step(Date.today + 30.days) { |date| schedules_to(date, ps) }
      end
    end

    private

    attr_accessor :professional

    def schedules_to(date, professional_service)
      office_hours = professional_service.professional.office_hours
      office_hours.where(week_day: date.cwday).each do |o_f|
        start_day = date_join_time(date, o_f.hour_begin)
        service_duration = professional_service.service.duration.minutes
        finish_day = date_join_time(date, o_f.hour_end) - service_duration
        step_time = duration_to_day(professional_service.service)

        start_day.step(finish_day, step_time) do |datetime|
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

    def duration_to_day(service)
      duration_in_hour = service.duration.to_f / 60.0
      hour_in_day = 1.0 / 24.0

      hour_in_day * duration_in_hour
    end
  end
end
