class ServicesController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[show]

  before_action :load_establishment, only: %i[index new create]
  before_action :load_service, only: %i[edit update destroy]

  def index; end

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
      redirect_to edit_establishment_service_path(@establishment, @service),
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

    if @service.archived?
      @service.awaiting_avaliation!

      redirect_to establishment_services_path(@service.establishment),
                  notice: 'Serviço foi desarquivado e para analise!'
      return
    end

    if @service.update_and_rebuild_schedule(service_params)
      redirect_to establishment_services_path(@service.establishment),
                  notice: 'Serviço atualizado com sucesso'
    else
      @professionals = @service.professionals_to_link
      render 'edit'
    end
  rescue ActionView::Template::Error => e
    @service.errors.full_messages.each { |error| flash[:error] = error }
    redirect_to edit_establishment_service_path(@service)
  end

  def destroy
    authorize @service

    @service.archived!

    redirect_to establishments_dashboard_path(@service.establishment),
                notice: 'Serviço arquivado!'
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
