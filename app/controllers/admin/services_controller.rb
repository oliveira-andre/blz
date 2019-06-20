module Admin
  class ServicesController < AdminController
    before_action :service, only: %i[show update]

    def index
      if params[:status].present?
        @services = Service.where(status: params[:status]) || Service.all
      else
        @services = Service.search(params[:query]) || Service.all
      end
      @pagy, @services = pagy(@services)
    end

    def show; end

    def update
      @service.update(status: params[:status])
      redirect_to admin_services_path
      flash[:success] = if params[:status] == 'approved'
                          'Aprovado com sucesso'
                        else
                          'Recusado com sucesso'
                        end
    end

    private

    def service
      @service = Service.find(params[:id])
    end
  end
end
