# frozen_string_literal: true

module Admin
  class SchedulingController < AdminController
    before_action :load_scheduling, only: :show

    def index
      @shedulings = Scheduling.all
      @pagy, @records = pagy_countless(@shedulings)
    end

    def show; end

    private

    def load_scheduling
      @scheduling = Scheduling.find(params[:id])
    end
  end
end
