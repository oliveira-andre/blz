class ReviewsController < ApplicationController
  def create
    redirect_to users_dashboard_path(current_user) if Review
                                                        .create(review_params)
  end

  private

  def review_params
    params.permit(:body, :rating)
      .merge(reviewable_id: params[:reviewable], user_id: current_user.id,
             reviewable_type: params[:review_type])
  end
end
