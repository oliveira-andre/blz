class FiltersController < ApplicationController
  skip_before_action :authenticate_user!

  def index
    @filter = filter_params
    @services = FilterServices.execute(@filter) || Service.approved
  end

  def destroy
    @filter = filter_params
    @services = FilterServices.execute(@filter) || Service.approved
  end

  private

  def filter_params
    params.permit(:query, :local_type, :category_id)
  end
end
