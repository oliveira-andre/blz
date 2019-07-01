# frozen_string_literal: true

class SchedulingController < ApplicationController
  skip_before_action :authenticate_user!, only: :new
  before_action :load_scheduling, only: :show

  def new
    @scheduling = Scheduling.new scheduling_new_params
    authorize @scheduling
  end

  def show
    authorize @scheduling
  end

  def create
    @scheduling = Scheduling.new scheduling_params
    authorize @scheduling

    if @scheduling.save
      flash[:success] = 'Agendamento realizado com sucesso!'
      redirect_to users_dashboard_path(current_user)
    else
      @scheduling.errors.full_messages.each { |msg| flash[:error] = msg }
      redirect_to service_path(id: @scheduling.service)
    end
  end

  private

  def scheduling_params
    params.require(:scheduling).permit(:professional_service_id, :date)
          .merge(user_id: current_user.id)
  end

  def load_scheduling
    @scheduling = Scheduling.find(params[:id])
  end

  def scheduling_new_params
    params.permit(:professional_service_id, :date)
  end
end
