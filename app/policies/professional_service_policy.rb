# frozen_string_literal: true

class ProfessionalServicePolicy < ApplicationPolicy
  def create?
    record.service.establishment.user == user &&
      record.professional.establishment.user == user
  end

  def destroy?
    record.service.establishment.user == user &&
      record.professional.establishment.user == user
  end
end
