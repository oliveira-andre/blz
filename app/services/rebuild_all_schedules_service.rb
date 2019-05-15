class RebuildAllSchedulesService
  class << self
    def execute
      ProfessionalService.all.each { |p_s| BuildScheduleService.execute(p_s) }
    end
  end
end
