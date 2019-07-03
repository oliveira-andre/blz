# frozen_string_literal: true

module Admin
  class ReviewsController < AdminController
    def index
      @reviews = if params[:status].present?
                   Review.where(status: params[:status]) || Review.all
                 else
                   Review.all
                 end
      @pagy, @reviews = pagy(@reviews)
    end
  end
end
