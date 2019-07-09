# frozen_string_literal: true

class SchedulingBusiesController < ApplicationController
  def create
    SchedulingBusiesService.execute(scheduling_params)
    flash[:success] = 'Período marcado como indisponível'
    redirect_to establishments_dashboard_path(params[:establishment_id])
  rescue ActiveRecord::RecordInvalid => e
    e.record.errors.full_messages.each { |error| flash[:error] = error }
    redirect_to establishments_dashboard_path(params[:establishment_id])
  end

  private

  def scheduling_params
    params.permit(:service_duration, :date_only, :time, :professional_id)
  end
end
