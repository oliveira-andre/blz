# frozen_string_literal: true

class SchedulingController < ApplicationController
  before_action :load_scheduling, only: %i[show destroy update]

  def new
    if current_user.registration_ok?
      @scheduling = Scheduling.new scheduling_new_params
      @scheduling.address = Address.new
    else
      redirect_to edit_service_users_path(service, scheduling_new_params)
    end
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

  def update
    if params[:status] == 'finished'
      @scheduling.finished!
      flash[:success] = 'Finalizado com sucesso'
    end

    redirect_to establishments_dashboard_path(
      @scheduling.professional_service.service.establishment
    )
  rescue ActiveRecord::RecordInvalid => e
    @scheduling.errors.full_messages.each { |error| flash[:error] = error }
    redirect_to establishments_dashboard_path(
      @scheduling.professional_service.service.establishment
    )
  end

  def destroy
    authorize @scheduling
    @scheduling.update!(scheduling_cancel_params)
    flash[:success] = 'Agendamento cancelado com sucesso'
    redirect_to scheduling_path(@scheduling)
  rescue ActiveRecord::RecordInvalid => e
    @scheduling.errors.full_messages.each { |msg| flash[:error] = msg }
    redirect_to scheduling_path(@scheduling)
  end

  private

  def scheduling_params
    params.require(:scheduling).permit(
      :professional_service_id, :date, :in_home,
      address_attributes: %i[id street number neighborhood zipcode]
    )
          .merge(user_id: current_user.id)
  end

  def load_scheduling
    @scheduling = Scheduling.find(params[:id])
  end

  def scheduling_new_params
    params.permit(:professional_service_id, :date)
  end

  def scheduling_cancel_params
    params.require(:scheduling).permit(:canceled_reason)
          .merge(status: :canceled, canceled_at: Time.now,
                 canceled_by: current_user.establishment.nil? ? 0 : 1)
  end

  def service
    @service ||= ProfessionalService.find(params[:professional_service_id])
                                    .service
  end
end
