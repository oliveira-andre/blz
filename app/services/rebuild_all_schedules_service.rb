class RebuildAllSchedulesService
  class << self
    def execute
      ProfessionalService.all.each { |p_s| BuildScheduleService.execute(p_s) }

      Scheduling.scheduled.each do |scheduling|
        professional = scheduling.professional_service.professional
        professional.professional_services.each do |ps|
          start_date = scheduling.date - (ps.service.duration.minutes - 1.minute)
          end_date = scheduling.date + (scheduling.service_duration.minutes - 1.minute)
          ps.schedules.where(date: (start_date..end_date)).update_all(free: false)
        end
      end
    end
  end
end
