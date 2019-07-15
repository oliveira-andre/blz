class EstablishmentWelcomesController < ApplicationController
  before_action :load_establishment

  def index; end

  private

  def load_establishment
    @establishment = Establishment.find(params[:establishment_id])
  end
end