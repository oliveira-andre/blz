class EstablishmentsDashboardController < ApplicationController
  def index
    @establishment = Establishment.find(params[:id])
    authorize @establishment
    @status = params[:establishments_dashboard_status]
    @date = params[:date]
    @scheduling = SchedulingFilter.execute(@status, @date, current_user)
    @scheduling_history = @establishment.scheduling.history
  end
end
