class SchedulingBusiesPolicy < ApplicationPolicy
  def create?
    record.establishment.present?
  end
end
