# frozen_string_literal: true

class ProfessionalPolicy < ApplicationPolicy
  def new?
    record.establishment.user == user
  end

  def create?
    record.establishment.user == user
  end

  def edit?
    record.establishment.user == user
  end

  def update?
    record.establishment.user == user
  end
end
