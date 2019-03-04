class SchedulingController < ApplicationController
  before_action :load_service

  def new
    @card_banners = [
      OpenStruct.new(id: 1, name: 'Visa'),
      OpenStruct.new(id: 2, name: 'Mastercad'),
      OpenStruct.new(id: 3, name: 'Elo'),
      OpenStruct.new(id: 4, name: 'American Express')
    ]

    @times_parcel = [
      OpenStruct.new(value: 1, times: '1 x 180,00'),
      OpenStruct.new(value: 2, times: '2 x 92,00'),
      OpenStruct.new(value: 3, times: '3 x 63,00')
    ]
  end

  def create
    if @service
      redirect_to user_dashboard_path(current_user)
    else
      render 'new'
    end
  end

  private

  def load_service
    @service = Service.find(params[:service_id])
  end
end
