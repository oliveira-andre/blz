# frozen_string_literal: true

class EstablishmentsDashboardController < ApplicationController
  def index
    @establishment = Establishment.find(params[:id])
    authorize @establishment
    @status = params[:schedunling_status]
    @date = params[:date]
    @scheduling = SchedulingFilter.execute(@status, @date, current_user)
    @scheduling_history = @establishment.scheduling.history
  end
end
