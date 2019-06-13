class Review < ApplicationRecord
  enum status: %i[analyze approved recused]

  belongs_to :reviewable, polymorphic: true
  belongs_to :user

  validates :body, presence: true
  validates :rating, presence: true,
            numericality: { greater_than_or_equal_to: 0,
                            less_than_or_equal_to: 5 }
end
