# frozen_string_literal: true

module Admin
  class ServicesController < AdminController
    before_action :load_service, only: %i[show update]

    def index
      @pagy, @services = pagy(services)
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
    rescue ActiveRecord::RecordInvalid => e
      e.record.errors.full_messages.each { |error| flash[:error] = error }
      redirect_to admin_service_path(@service)
    end

    private

    def load_service
      @service = Service.find(params[:id])
    end

    def services
      if params[:status].present?
        Service.where(status: params[:status])
      elsif params[:query].present?
        Service.search(params[:query])
      else
        Service.awaiting_avaliation
      end
    end
  end
end
