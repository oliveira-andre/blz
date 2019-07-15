# frozen_string_literal: true

module Admin
  class EstablishmentsController < AdminController
    before_action :load_establishment, only: %i[show update]

    def index
      @pagy, @establishments = pagy(establishments)
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

    def establishments
      if params[:status].present?
        Establishment.where(status: params[:status])
      elsif params[:query].present?
        Establishment.search(params[:query])
      elsif Establishment.analyze.empty?
        Establishment.all
      else
        Establishment.analyze
      end
    end
  end
end
