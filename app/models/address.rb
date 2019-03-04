class Address < ApplicationRecord
  belongs_to :establishment

  validates :street, presence: true
  validates :number, presence: true
  validates :neighborhood, presence: true
end
