class SchedulingBusiesPolicy < ApplicationPolicy
  def create?
    record.establishment.present? && record.establishment.user == user
  end
end
