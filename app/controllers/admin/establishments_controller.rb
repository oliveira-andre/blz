module Admin
  class EstablishmentsController < AdminController
    before_action :load_establishment, only: %i[show update]

    def index
      @establishments = Establishment.all
      @pagy, @establishments = pagy(@establishments)
    end

    def show; end

    def update
      if params[:status] == 'approved'
        @establishment.approved!
        flash[:success] = 'Aprovado com sucesso'
      end

      if params[:status] == 'disapproved'
        @establishment.disapproved!
        flash[:success] = 'Reprovado com sucesso'
      end

      redirect_to admin_establishments_path
    rescue ActiveRecord::RecordInvalid => e
      @establishment.errors.full_messages.each { |error| flash[:error] = error }
      redirect_to admin_establishment_path(@establishment)
    end

    private

    def load_establishment
      @establishment = Establishment.find(params[:id])
    end
  end
end
