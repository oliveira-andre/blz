class UsersDashboardController < ApplicationController
  def index
    @status = params[:users_dashboard_status]
    if @status.present?
      scheduling_filter = current_user.scheduling.where(
        status: @status.to_sym
      )
      if scheduling_filter.empty?
        @scheduling = current_user.scheduling
      else
        @scheduling = scheduling_filter
      end 
    else
      @scheduling = current_user.scheduling
    end
  end
end
