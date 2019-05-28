module Admin
  class ServicesController < AdminController
    def index
      if params[:filter].present?
        @services = Service.where(status: params[:filter]) || Service.all
      else
        @services = Service.search(params[:search]) || Service.all
      end
      @pagy, @services = pagy(@services)
    end
  end
end