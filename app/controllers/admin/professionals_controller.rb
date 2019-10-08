# frozen_string_literal: true

module Admin
  class ProfessionalsController < AdminController
    def index
      @pagy, @professionals = pagy(professionals)
    end

    private

    def professionals
      return Professional.all unless params[:query]

      Professional.search(params[:query])
    end
  end
end
