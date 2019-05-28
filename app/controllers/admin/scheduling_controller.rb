module Admin
  class SchedulingController < AdminController
    def index
      @shedulings = Scheduling.all
      @pagy, @shedulings = pagy(@shedulings)
    end
  end
end