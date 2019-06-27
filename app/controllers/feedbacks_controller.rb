# frozen_string_literal: true

class FeedbacksController < ApplicationController
  skip_before_action :authenticate_user!, only: :index
  before_action :load_establishment, only: :index

  def index; end

  private

  def load_establishment
    @establishment = Establishment.find(params[:establishment_id])
  end
end
