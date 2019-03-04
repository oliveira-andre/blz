class ServicesController < ApplicationController
  before_action :load_establishment, only: %i[index new create]
  before_action :load_services, only: %i[edit update]

  def index
    authorize @establishment, policy_class: ServicePolicy
    @services = @establishment.services
  end

  def new
    authorize @establishment, policy_class: ServicePolicy
    @service = @establishment.services.build
  end

  def create
    @service = @establishment.services.build(service_params)
    authorize @service
    if @service.save
      redirect_to establishment_services_path, notice: 'Salvo com sucesso'
    else
      render 'new'
    end
  end

  def edit
    authorize @service
  end

  def update
    authorize @service
    if @service.update(service_params)
      redirect_to establishment_services_path, notice: 'Atualizado com sucesso'
    else
      render 'edit'
    end
  end

  private

  def load_establishment
    @establishment = Establishment.find(params[:establishment_id])
  end

  def load_services
    @service = Service.find(params[:id])
  end

  def service_params
    params.require(:service).permit(:title, :description, :amount, :duration,
                                    :category_id, :local_type, :status,
                                    photos: [])
  end
end