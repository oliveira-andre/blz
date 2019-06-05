class ReviewPolicy < ApplicationPolicy
  def new?(scheduling)
    scheduling.finished? && scheduling.user == user && scheduling.review.nil?
  end

  def create?
    new?(record)
  end

  def show?(scheduling)
    scheduling.finished? && scheduling.user == user && scheduling.review.present?
  end
end
