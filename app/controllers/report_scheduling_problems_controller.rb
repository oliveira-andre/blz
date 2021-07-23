# frozen_string_literal: true

class ReportSchedulingProblemsController < ApplicationController
  before_action :load_scheduling

  def create
    @report = ReportProblem.new report_params

    if @report.save
      flash[:success] = 'O seu problema foi reportado e enviado para
                         a equipe BLZ'
    else
      @report.errors.full_messages.each { |error| flash[:error] = error }
    end
    redirect_to scheduling_path(@scheduling)
  end

  private

  def report_params
    params.require(:report_problem).permit(:category, :body)
          .merge(user: current_user,
                 reportable: @scheduling)
  end

  def load_scheduling
    @scheduling = Scheduling.find(params[:scheduling_id])
  end
end
