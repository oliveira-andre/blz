# frozen_string_literal: true

module Admin
  class EstablishmentsController < AdminController
    before_action :load_establishment, only: %i[show update edit]

    def index
      @pagy, @establishments = pagy(establishments)
    end

    def edit; end

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

      if @establishment.update!(establishment_params)
        flash[:success] = 'Estabelecimento atualizado com sucesso'
      end

      redirect_to admin_establishments_path
    rescue ActiveRecord::RecordInvalid => e
      @establishment.errors.full_messages.each { |error| flash[:error] = error }
      redirect_to admin_establishments_path
    end

    private

    def establishment_params
      params.require(:establishment)
            .permit(
              :photo, :about, :name, :timetable, :self_employed,
              address_attributes: %i[id street number neighborhood zipcode],
              user_attributes: %i[id phone]
            )
    end

    def load_establishment
      @establishment = Establishment.find(params[:id])
    end

    def establishments
      if params[:status].present?
        Establishment.where(status: params[:status])
      elsif params[:query].present?
        Establishment.search(params[:query])
      else
        Establishment.analyze
      end
    end
  end
end
