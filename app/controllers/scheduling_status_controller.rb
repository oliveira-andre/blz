# frozen_string_literal: true

class SchedulingStatusController < ApplicationController
  before_action :load_scheduling, only: %i[update]

  def update
    authorize @scheduling, policy_class: SchedulingStatusPolicy
    if send "set_status_#{params[:status]}"
      redirect_to establishments_dashboard_path(
        @scheduling.professional_service.service.establishment
      )
    end
  rescue ActiveRecord::RecordInvalid => e
    @scheduling.errors.full_messages.each { |error| flash[:error] = error }
    redirect_to establishments_dashboard_path(
      @scheduling.professional_service.service.establishment
    )
  end

  private

  def method_missing(_method_name)
    redirect_back(fallback_location: establishments_dashboard_path(
      @scheduling.professional_service.service.establishment
    ), alert: 'Status não encontrado') && return
  end

  def load_scheduling
    @scheduling = Scheduling.find(params[:scheduling_id])
  end

  def set_status_recused
    @scheduling.recused!
    flash[:success] = 'Recusado com sucesso'
  end

  def set_status_scheduled
    @scheduling.scheduled!
    flash[:success] = 'Aceito com sucesso'
  end

  def set_status_finished
    @scheduling.finished!
    flash[:success] = 'Finalizado com sucesso'
  end
end
