# frozen_string_literal: true

class EstablishmentFeedbacksController < ApplicationController
  skip_before_action :authenticate_user!, only: :index

  def index
    @email = params[:email]
  end
end
