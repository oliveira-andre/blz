class Service < ApplicationRecord
  enum status: %i[approved recused awaiting_avaliation archived]
  enum local_type: %i[home establishment]

  has_many_attached :photos

  belongs_to :category
  belongs_to :establishment

  has_many :office_hours

  validates :title, presence: true
  validates :description, presence: true
  validates :amount, presence: true
  validates :duration, presence: true
  validates :local_type, presence: true
  validates :status, presence: true

  validates :title, uniqueness: { scope: :establishment_id }
end
