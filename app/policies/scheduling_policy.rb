class SchedulingPolicy < ApplicationPolicy
  def create?
    user.establishment.nil? && user.registration_ok?
  end

  def show?
    record.user == user ||
      record.service.establishment.user == user
  end
end
