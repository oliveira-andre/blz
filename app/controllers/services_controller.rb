class ServicesController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[show]
  before_action :load_establishment, only: %i[index new create]
  before_action :load_service, only: %i[edit update]

  def show
    @service = Service.approved.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    flash[:error] = 'Serviço não encontrado!'
    redirect_to root_path
  end

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
      flash[:error] = @service.errors.full_messages.to_sentence
      redirect_to establishments_dashboard_path(@establishment)
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
      flash[:error] = @service.errors.full_messages.to_sentence
      redirect_back(fallback_location: establishment_service_path(@service))
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
