class ServicePolicy < ApplicationPolicy

  def index?
    record.user == user
  end

  def create?
    true
  end

  def new?
    true
  end
end