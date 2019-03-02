class Service < ApplicationRecord
  belongs_to :category
  belongs_to :estableshment

  validates :title, presence: true
  validates :description, presence: true
  validates :amount, presence: true
  validates :duration, presence: true
  validates :timetable, presence: true

  validates :title, uniqueness: { scope: :establishment_id }
end
