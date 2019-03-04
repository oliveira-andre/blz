class ServicePolicy < ApplicationPolicy

  def index?
    record.user == user
  end

  def new?
    record.user == user
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

end
