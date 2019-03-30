class UsersDashboardController < ApplicationController
  def index
    @scheduling = current_user.scheduling
  end
end
