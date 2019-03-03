class Service < ApplicationRecord
  enum status: %i[approved recused awaiting_avaliation archived]
  enum local_type: %i[home establishment]

  belongs_to :category
  belongs_to :establishment

  validates :title, presence: true
  validates :description, presence: true
  validates :amount, presence: true
  validates :duration, presence: true

  validates :title, uniqueness: { scope: :establishment_id }
end
