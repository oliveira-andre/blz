class BusiesController < ApplicationController
  def create
    @scheduling = Scheduling.new(scheduling_params).busy!

    if @scheduling.save
      flash[:success] = 'Profissional ocupado com sucesso'
    else
      @scheduling.errors.full_messages.each { |error| flash[:error] = error }
    end

    redirect_to establishments_dashboard_path(@scheduling.service.establishment)
  end

  private

  def scheduling_params
    params.permit(:establishment_professionals, :service_duration)
          .merge(date: "#{params[:date_only]} #{params[:time]}".to_time)
  end
end