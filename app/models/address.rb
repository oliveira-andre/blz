class Address < ApplicationRecord
  belongs_to :establishment

  validates :street, presence: true
  validates :number, presence: true
  validates :neighborhood, presence: true

  def full
    "#{street}, #{number}, #{neighborhood} - #{city} / #{state.upcase[0..1]}"
  end
end
