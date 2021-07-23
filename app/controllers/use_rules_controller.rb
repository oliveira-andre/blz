# frozen_string_literal: true

class UseRulesController < ApplicationController
  skip_before_action :authenticate_user!

  def index; end
end
