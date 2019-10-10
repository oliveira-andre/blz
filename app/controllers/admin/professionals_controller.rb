# frozen_string_literal: true

module Admin
  class ProfessionalsController < AdminController
    before_action :load_professional, only: %i[edit update]

    def index
      @professionals = if params[:query]
                         Professional.search(params[:query])
                       else
                         Professional.all
                       end
      @pagy, @professionals = pagy(@professionals)
    end

    def edit; end

    def update
      @professional.update!(professional_params)
      flash[:success] = 'Atualizado com sucesso'
      redirect_to admin_professionals_path
    rescue ActiveRecord::RecordInvalid => e
      e.errors.full_messages.each { |error| flash[:error] = error }
      redirect_to admin_professionals_path
    end

    def destroy
      @professional.destroy!
      redirect_to admin_professionals_path,
                  notice: 'Profissional excluído com sucesso'
    end

    private

    def load_professional
      @professional = Professional.find(params[:id])
    end

    def professional_params
      params.require(:professional).permit(:name, :description, :photo)
    end
  end
end
