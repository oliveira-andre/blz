class FilterServicesController < ApplicationController
  skip_before_action :authenticate_user!
  include Pagy::Backend

  def index
    @filter = filter_params.to_hash
    @services = FiltersService.execute(@filter)
    @pagy, @services = pagy(@services, items: 30)
  end

  private

  def filter_params
    params.permit(:query, :category, :date, :local_type, :price)
  end
end
