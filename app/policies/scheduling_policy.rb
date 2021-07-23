# frozen_string_literal: true

class SchedulingPolicy < ApplicationPolicy
  def new?
    user.establishment.nil?
  end

  def create?
    user.establishment.nil? && user.registration_ok?
  end

  def update?
    record.service.establishment.user == user
  end

  def show?
    record.user == user ||
      record.service.establishment.user == user
  end

  def destroy?
    record.user == user ||
      record.service.establishment.user == user
  end
end
