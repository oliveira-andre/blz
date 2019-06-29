# frozen_string_literal: true

class SchedulingController < ApplicationController
  skip_before_action :authenticate_user!, only: :new
  before_action :load_scheduling, only: %i[show destroy]

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

  def destroy
    @scheduling.update(scheduling_cancel_params)
    @scheduling.canceled!
    flash[:success] = 'Agendamento cancelado com sucesso'
    redirect_to scheduling_path(@scheduling)
  rescue ActiveRecord::RecordInvalid => e
    @scheduling.errors.full_messages.each { |msg| flash[:error] = msg }
    redirect_to scheduling_path(@scheduling)
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

  def scheduling_cancel_params
    params.permit(:canceled_reason).merge(canceled_at: Time.now,
                                          canceled_by: current_user
                                          .establishment.nil? ? 0 : 1)
  end
end
