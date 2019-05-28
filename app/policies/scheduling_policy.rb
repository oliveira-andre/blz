class SchedulingPolicy < ApplicationPolicy
  def create?
    user.establishment.nil?
  end

  def show?
    record.user == user ||
      record.professional_service.service.establishment.user == user
  end
end
