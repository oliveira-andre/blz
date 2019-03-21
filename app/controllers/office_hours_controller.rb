class OfficeHoursController < ApplicationController
  before_action :clean_hours, only: :create

  def create
    @office_hour = OfficeHour.new(office_hours_params)
    if @office_hour.save
      flash[:success] = 'Horário cadastrado com sucesso!'
    else
      @office_hour.errors.full_messages.each do |msg|
        flash[:error] = msg
      end
    end
    redirect_to_professional
  end

  def destroy
    @office_hour = OfficeHour.find(params[:id])
    @office_hour.destroy
    flash[:success] = 'Horário removido com sucesso!'
    redirect_to_professional
  end

  private

  def clean_hours
    params[:hour_begin].delete!(':')
    params[:hour_end].delete!(':')
  end
  def office_hours_params
    params.permit(:hour_begin, :hour_end, :week_day, :professional_id)
  end

  def redirect_to_professional
    redirect_to edit_establishment_professional_path(
      establishment_id: @office_hour.professional.establishment_id,
      id: @office_hour.professional_id
    )
  end
end
