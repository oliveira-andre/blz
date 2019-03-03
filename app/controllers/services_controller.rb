class ServicesController < ApplicationController
  before_action :load_establishment

  def index
    authorize @establishment, policy_class: ServicePolicy
    @services = @establishment.services
  end

  private

  def service_scope
    policy_scope(Service)
  end

  def load_establishment
    @establishment = Establishment.find(params[:establishment_id])
  end

  def service_params
    require(:service).permit(:photo)
  end
end