# frozen_string_literal: true

class EstablishmentPolicy < ApplicationPolicy
  def index?
    record.user_id == user.id
  end

  def new?
    user.nil?
  end

  def create?
    user.nil?
  end

  def edit?
    record.user.id == user.id
  end

  def update?
    record.user.id == user.id
  end
end
