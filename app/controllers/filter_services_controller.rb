class FilterServicesController < ApplicationController
  skip_before_action :authenticate_user!

  def index
    @filter = filter_params.to_hash
    @services = FiltersService.execute(@filter)
  end

  private

  def filter_params
    params.permit(:query, :category, :date)
  end
end
