class ServicesController < ApplicationController
  before_action :load_establishment

  def index
    authorize @establishment, policy_class: ServicePolicy
    @services = @establishment.services
  end

  def new
    @service = @establishment.services.build
  end

  def create
    @service = @establishment.services.build(service_params)
    if @service.save
      redirect_to establishment_services_path, notice: "Salvo com sucesso"
    else
      render 'new'
    end
  end

  private

  def load_establishment
    @establishment = Establishment.find(params[:establishment_id])
  end

  def service_params
    params.require(:service).permit(:title, :description, :amount, :duration,
                                    :category_id, :local_type, :status,
                                    photos: [])
  end
end