# frozen_string_literal: true

module SchedulingBusiesService
  class << self
    def execute(params)
      @date_only = params.fetch(:date_only)
      @time = params.fetch(:time)
      @professional_id = params.fetch(:professional_id)
      @service_duration = params.fetch(:service_duration)

      professional_services.each { |p_s| create_scheduling!(p_s) }
    end

    private

    attr_accessor :professional_id, :date_only, :time, :service_duration

    def create_scheduling!(professional_service)
      Scheduling.create!(
        service_duration: service_duration,
        date: date_formated,
        professional_service: professional_service,
        status: :busy
      )
    end

    def professional_services
      ProfessionalService.where(professional_id: professional_id)
    end

    def date_formated
      "#{date_only} #{time} UTC"
    end
  end
end
