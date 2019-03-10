class EstablishmentPolicy < ApplicationPolicy
  def index?
    record.user_id == user.id
  end
end
