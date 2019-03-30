class SchedulingController < ApplicationController
  def new
    @professional_service = ProfessionalService.find(
      params[:professional_service_id]
    )

    @date = params[:date].to_datetime
  end

  def create
    @scheduling = Scheduling.new scheduling_params
    authorize @scheduling

    @scheduling.service_duration = @scheduling.professional_service
                                              .service.duration

    if @scheduling.save
      flash[:success] = 'Agendamento realizado com sucesso!'
      redirect_to users_dashboard_path(id: @scheduling.user.id)
    else
      add_flash_message
      redirect_to service_path(id: @scheduling.professional_service.service)
    end
  end

  private

  def scheduling_params
    params.permit(:professional_service_id, :date)
          .merge(user_id: current_user.id)
  end

  def add_flash_message
    @scheduling.errors.full_messages.each do |message|
      flash[:error] = message
    end
  end
end
