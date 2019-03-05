class SchedulingPolicy < ApplicationPolicy
  def create?
    (user != record.service.establishment.user) && user.establishment.nil?
  end
end
