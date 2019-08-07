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
end
