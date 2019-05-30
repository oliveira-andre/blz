module Admin
  class ServicesController < AdminController
    def index
      if params[:status].present?
        @services = Service.where(status: params[:status]) || Service.all
      else
        @services = Service.search(params[:query]) || Service.all
      end
      @pagy, @services = pagy(@services)
    end
  end
end