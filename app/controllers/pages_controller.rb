# frozen_string_literal: true

class PagesController < ApplicationController
  skip_before_action :authenticate_user!

  def home
    @services = Service.approved
  end

  def sales; end
end
