class ServicesController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[show details]

  before_action :load_establishment, only: %i[index new create]
  before_action :load_service, only: %i[edit update show details]

  def index
    authorize @establishment, policy_class: ServicePolicy
    @services = @establishment.services
  end

  def show
    # TODO: isso é provisorio, remover e aplicar a regra real depois
    @first_timetable = params[:ftime].to_datetime || '04/03/2019 21:15'.to_datetime
  end

  def details
    @begin_time = params[:timetable].to_datetime
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

  def load_service
    @service = Service.find(params[:id] || params[:service_id])
  end

  def service_params
    params.require(:service).permit(:title, :description, :amount, :duration,
                                    :category_id, :local_type, :status,
                                    photos: [])
  end
end
