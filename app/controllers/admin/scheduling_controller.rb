module Admin
  class SchedulingController < AdminController
    def index
      @shedulings = Scheduling.all
      @pagy, @records  = pagy_countless(@shedulings)
    end
  end
end