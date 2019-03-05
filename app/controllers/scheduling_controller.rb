class SchedulingController < ApplicationController
  def create
    @scheduling = Scheduling.new scheduling_params
    authorize @scheduling

    if @scheduling.save
      redirect_to user_dashboard_path(id: @scheduling.user.id)
    else
      @scheduling.errors.full_messages.each do |message|
        flash[:error] = message
      end
      redirect_to service_path(id: @scheduling.service.id)
    end
  end

  private

  def scheduling_params
    params.permit(:service_id, :timetable).merge(user_id: current_user.id)
  end
end
