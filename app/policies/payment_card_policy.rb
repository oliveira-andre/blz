class PaymentCardPolicy < ApplicationPolicy
  def show?
    record.user_id == user.id
  end

  def destroy?
    record.user_id == user.id
  end
end
