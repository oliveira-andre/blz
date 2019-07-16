class EstablishmentWelcomesController < ApplicationController
  before_action :load_establishment

  def index
    authorize @establishment
  end

  private

  def load_establishment
    @establishment = Establishment.find(params[:establishment_id])
  end
end