class OfficeHoursController < ApplicationController
  before_action :clean_hours, only: :create

  def create
    @office_hour = OfficeHour.new(office_hours_params)
    if @office_hour.save!
      redirect_to edit_establishment_service_path(@office_hour.service.establishment.id, @office_hour.service)
    else
      flash[:error] = 'Campos inválidos, verifique se estão corretos'
      redirect_to edit_establishment_service_path(@office_hour.service.establishment.id, @office_hour.service)
    end
  end

  def destroy
    @office_hour = OfficeHour.find(params[:id])
    redirect_to edit_establishment_service_path(@office_hour.service.establishment.id, @office_hour.service) if @office_hour.destroy
  end

  private

  def office_hours_params
    params.permit(:hour_begin, :hour_end, :week_day, :service_id)
  end

  def clean_hours
    params[:hour_begin].delete!(':')
    params[:hour_end].delete!(':')
  end
end