class SchedulingController < ApplicationController
  def create
    @scheduling = Scheduling.new scheduling_params
    @scheduling.end_time = @scheduling.begin_time +
                           @scheduling.service.duration.minutes
    authorize @scheduling

    if @scheduling.save
      redirect_to user_dashboard_path(id: @scheduling.user.id)
    else
      add_flash_message
      redirect_to service_path(id: @scheduling.service.id)
    end
  end

  private

  def scheduling_params
    params.permit(:service_id, :begin_time).merge(user_id: current_user.id)
  end

  def add_flash_message
    @scheduling.errors.full_messages.each do |message|
      flash[:error] = message
    end
  end
end
