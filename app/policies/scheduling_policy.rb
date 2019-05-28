class SchedulingPolicy < ApplicationPolicy
  def create?
    user.establishment.nil?
  end

  def show?
    record.user == user ||
      record.service.establishment.user == user
  end
end
