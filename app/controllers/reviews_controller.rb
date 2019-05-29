class ReviewsController < ApplicationController
  before_action :load_scheduling

  def create
    authorize @scheduling, policy_class: ReviewPolicy
    @review = Review.new(review_params)
    redirect_to users_dashboard_path(current_user)

    if @review.save
      flash[:success] =  'Avaliado com sucesso!'
    else
      @review.errors.full_messages.each { |error| flash[:error] = error }
    end
  end

  private

  def review_params
    params.permit(:body, :rating).merge(user: current_user,
                                        reviewable: @scheduling)
  end

  def load_scheduling
    @scheduling = Scheduling.find(params[:scheduling_id])
  end
end
