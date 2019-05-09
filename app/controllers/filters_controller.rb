class FiltersController < ApplicationController
  skip_before_action :authenticate_user!

  def index
    @filter = filter_params
    @services = FiltersService.execute(@filter) || Service.approved
  end

  def destroy
    @filter = filter_params
    @services = FiltersService.execute(@filter) || Service.approved
  end

  private

  def filter_params
    params.permit(:query, :date, categories_ids: [], local_type: [])
  end
end
