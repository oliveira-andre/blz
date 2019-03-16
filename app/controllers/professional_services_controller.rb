class ProfessionalServicesController < ApplicationController
  def create
    @p_s = ProfessionalService.new professional_service_params
    authorize @p_s
    if @p_s.save
      flash[:success] = 'Profissional vinculado!'
    else
      flash[:erro] = 'Não foi possível vincular o profissional :('
    end

    redirect_to edit_establishment_service_path(
      @p_s.service.establishment_id,
      @p_s.service_id
    )
  end

  def destroy
    @p_s = ProfessionalService.find(params[:id])
    authorize @p_s
    service = @p_s.service

    @p_s.destroy

    flash[:success] = 'Profissional desvinculado!'

    redirect_to edit_establishment_service_path(
      service.establishment_id,
      service.id
    )
  end

  private

  def professional_service_params
    params.require(:professional_service)
          .permit(:professional_id)
          .merge(service_id: params[:service_id])
  end
end
