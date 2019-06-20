class ProfessionalsController < ApplicationController
  before_action :load_establishment
  before_action :load_professional, only: %i[edit update]

  def index; end

  def new
    @professional = @establishment.professionals.build
    authorize @professional
  end

  def create
    @professional = Professional.new professional_params
    authorize @professional
    if @professional.save
      redirect_to establishments_dashboard_path(@establishment),
                  notice: 'Profissional criado com sucesso'
    else
      render 'new'
    end
  end

  def edit
    authorize @professional
  end

  def update
    authorize @professional
    if @professional.update professional_params
      redirect_to establishments_dashboard_path(@establishment),
                  notice: 'Profissional atualizado com sucesso'
    else
      render 'edit'
    end
  end

  private

  def load_establishment
    @establishment = Establishment.find(params[:establishment_id])
  end

  def load_professional
    @professional = @establishment.professionals.find(params[:id])
  end

  def professional_params
    params.require(:professional)
          .permit(:name, :description, :photo)
          .merge(establishment_id: @establishment.id)
  end
end
