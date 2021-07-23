# frozen_string_literal: true

class EstablishmentWelcomesPolicy < ApplicationPolicy
  def index?
    record.user_id == user.id
  end
end
