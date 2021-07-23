# frozen_string_literal: true

class SchedulingStatusPolicy < ApplicationPolicy
  def update?
    record.service.establishment.user == user
  end
end
