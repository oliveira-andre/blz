class UserDashboardController < ApplicationController
  def index
    @scheduling = current_user.scheduling
  end
end