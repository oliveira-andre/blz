# frozen_string_literal: true

module SchedulingBusiesService
  class << self
    def execute(params)
      professional_services(params).each do |professional_service|
        @scheduling = Scheduling.new(
          scheduling_params(params, professional_service)
        )
        @scheduling.busy!
      end
    end

    def scheduling_params(params, professional_service)
      params.permit(:service_duration).merge(
        date: "#{params[:date_only]} #{params[:time]} UTC".to_time,
        professional_service: professional_service
      )
    end

    def professional_services(params)
      @professional_services ||= ProfessionalService.where(
        professional_id: params[:professional_id]
      )
    end
  end
end
