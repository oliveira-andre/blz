# frozen_string_literal: true

module Admin
  class ProfessionalsController < AdminController
    def index
      @professionals = if params[:query]
                         Professional.search(params[:query])
                       else
                         Professional.all
                       end
      @pagy, @professionals = pagy(@professionals)
    end
  end
end
