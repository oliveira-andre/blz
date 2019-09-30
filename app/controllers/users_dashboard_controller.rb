class UsersDashboardController < ApplicationController
  def index
    @status = params[:users_dashboard_status]
    @scheduling = SchedulingFilter.execute(@status, nil, current_user)
    debugger
  end
end
