# frozen_string_literal: true

class BusiesController < ApplicationController
  def create
    professional_services.each do |professional_service|
      @scheduling = Scheduling.new(scheduling_params.merge(
                                     professional_service: professional_service
                                   ))
      @scheduling.busy!
    end
    flash[:success] = 'Profissional ocupado com sucesso'
    redirect_to establishments_dashboard_path(@scheduling.service.establishment)
  rescue ActiveRecord::RecordInvalid => e
    @scheduling.errors.full_messages.each { |error| flash[:error] = error }
    redirect_to establishments_dashboard_path(@scheduling.service.establishment)
  end

  private

  def scheduling_params
    params.permit(:service_duration)
          .merge(
            date: "#{params[:date_only]} #{params[:time]} UTC".to_time
          )
  end

  def professional_services
    @professional_services ||= ProfessionalService.where(
      professional: params[:professional]
    )
  end
end
