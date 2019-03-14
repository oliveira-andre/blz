class BuildScheduleService
	class << self
    def execute(professional_service)
      duration = (professional_service.service.duration.to_f / 60)
      professional_service.schedules.destroy_all
      (0..45).each do |day|
        datetime = Date.today + day.days
        week_day = datetime.strftime('%w').to_i

        professional_service.office_hours.where(week_day: week_day).each do |office_hour|
          time_to_work = office_hour.hour_end - office_hour.hour_begin
          time = datetime + office_hour.hour_begin.hours

          while time_to_work >= duration
            time += (duration*60).minutes
            schedule = Schedule.find_or_create_by!(
              date: time,
              free: true,
              professional_service_id: professional_service.id
            )
            time_to_work -= duration
          end
        end
      end
    end
  end
end

# BuildScheduleService.execute ProfessionalService.first
# Schedule.all.each {|s| p " --- #{I18n.l(s.date, format: :day_month)} às #{I18n.l(s.date, format: :time)} --- "}
# Schedule.destroy_all
