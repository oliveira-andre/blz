class ServicesController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[show details]

  before_action :load_establishment, only: %i[index new create]
  before_action :load_service, only: %i[edit update show details]

  def show
    # TODO: isso eh provisorio, remover e aplicar a regra real depois
    @first_timetable = params[:ftime].to_datetime if params[:ftime]
    @first_timetable = '07/03/2019 15:00'.to_datetime unless params[:ftime]
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
      redirect_to establishments_dashboard_path(@establishment),
                  notice: 'Serviço criado com sucesso'
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
