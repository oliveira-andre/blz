class ServicesController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[show details]

  before_action :load_establishment, only: %i[index new create]
  before_action :load_service, only: %i[edit update show details]

  def show; end

  def new
    authorize @establishment, policy_class: ServicePolicy
    @service = @establishment.services.build
  end

  def create
    @service = @establishment.services.build(service_params)
    authorize @service
    if @service.save
      redirect_to establishments_dashboard_path(@establishment),
                  notice: 'Serviço criado com sucesso'
    else
      render 'new'
    end
  end

  def edit
    authorize @service
    @professionals = @service.professionals_to_link
  end

  def update
    authorize @service
    if @service.update(service_params)
      redirect_to establishments_dashboard_path(@service.establishment),
                  notice: 'Serviço atualizado com sucesso'
    else
      render 'edit'
    end
  end

  private

  def load_establishment
    @establishment = Establishment.find(params[:establishment_id])
  end

  def load_service
    @service = Service.find(params[:id] || params[:service_id])
  end

  def service_params
    params.require(:service).permit(:title, :description, :amount, :duration,
                                    :category_id, :local_type, :status,
                                    photos: [])
  end
end
