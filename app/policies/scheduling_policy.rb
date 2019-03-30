class SchedulingPolicy < ApplicationPolicy
  def create?
    user.establishment.nil?
  end
end
