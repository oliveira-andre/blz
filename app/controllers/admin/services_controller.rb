module Admin
  class ServicesController < AdminController
    before_action :load_service, only: %i[show update]

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
      if params[:status] == 'approved'
        @service.approved!
        flash[:success] = 'Aprovado com sucesso'
      end

      if params[:status] == 'recused'
        @service.recused!
        flash[:success] = 'Recusado com sucesso'
      end

      redirect_to admin_services_path
    end

    private

    def load_service
      @service = Service.find(params[:id])
    end
  end
end
