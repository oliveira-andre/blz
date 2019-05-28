class ReviewsController < ApplicationController
  before_action :load_scheduling

  def create
    authorize @load_scheduling, policy_class: ReviewPolicy
    @review = Review.new(review_params)
    redirect_to users_dashboard_path(current_user) if @review.save
  end

  private

  def review_params
    params.permit(:body, :rating).merge(user: current_user,
                                        reviewable: @load_scheduling)
  end

  def load_scheduling
    @load_scheduling = Scheduling.find(params[:scheduling_id])
  end
end
