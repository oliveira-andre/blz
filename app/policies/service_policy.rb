class ServicePolicy < ApplicationPolicy
  def index?
    !user.establishment.nil?
  end

  def new?
    !user.establishment.nil?
  end

  def create?
    record.establishment.user == user
  end

  def edit?
    record.establishment.user == user
  end

  def update?
    record.establishment.user == user
  end

  def destroy?
    record.establishment.user == user
  end
end
