# frozen_string_literal: true

module Admin
  class ReviewsController < AdminController
    before_action :load_review, only: %i[show update]
    before_action :load_scheduling, only: :show

    def index
      @pagy, @reviews = pagy(reviews)
    end

    def show; end

    def update
      if params[:status] == 'approved'
        @review.approved!
        flash[:success] = 'Aprovado com sucesso'
      end

      if params[:status] == 'recused'
        @review.recused!
        flash[:success] = 'Recusado com sucesso'
      end

      redirect_to admin_reviews_path
    rescue ActiveRecord::RecordInvalid => e
      e.record.errors.full_messages.each { |error| flash[:error] = error }
      redirect_to admin_review_path(@review)
    end

    private

    def load_review
      @review = Review.find(params[:id])
    end

    def load_scheduling
      @scheduling = Scheduling.find(@review.reviewable_id)
    end

    def reviews
      if params[:status].present?
        Review.where(status: params[:status]) || Review.analyze
      elsif Review.analyze.empty?
        Review.all
      else
        Review.analyze
      end
    end
  end
end
