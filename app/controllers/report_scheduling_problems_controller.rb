class ReportSchedulingProblemsController < ApplicationController
  before_action :load_scheduling

  def create
    @report = ReportSchedulingProblem.new report_params

    if @report.save
      flash[:success] = 'O seu reporte foi criado e enviado para os
                         adminstradores'
    else
      @report.errors.full_messages.each { |error| flash[:error] = error }
    end
    redirect_to scheduling_path(@load_scheduling)
  end

  private

  def report_params
    params.require(:report_scheduling_problem).permit(:category, :body)
  end

  def load_scheduling
    @load_scheduling = Scheduling.find(params[:scheduling_id])
  end
end
