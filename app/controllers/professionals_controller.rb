class ProfessionalsController < ApplicationController
  before_action :load_establishment
  before_action :load_professional, only: %i[edit update]

  def new
    @professional = @establishment.professionals.build
  end

  def create
    @professional = Professional.new professional_params
    if @professional.save
      redirect_to establishments_dashboard_path(@establishment),
                  notice: 'Profissional criado com sucesso'
    else
      render 'new'
    end
  end

  def edit; end

  def update
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
          .permit(:name, :description)
          .merge(establishment_id: @establishment.id)
  end
end
