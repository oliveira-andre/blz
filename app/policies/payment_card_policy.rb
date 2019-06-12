class PaymentCardPolicy < ApplicationPolicy
  def index?
    record.each{ |payment_card| payment_card.user_id == user.id }
  end

  def show?
    record.user_id == user.id
  end

  def destroy?
    record.user_id == user.id
  end
end
