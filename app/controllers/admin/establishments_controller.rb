module Admin
  class EstablishmentsController < AdminController
    def index
      @establishments = Establishment.all
      @pagy, @establishments = pagy(@establishments)
    end
  end
end
