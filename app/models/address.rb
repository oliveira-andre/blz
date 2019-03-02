class Address < ApplicationRecord
  belongs_to :establishment

  validates :street, presence: true
  validates :numder, presence: true
  validates :neighborhood, presence: true
end
