# frozen_string_literal: true

class Address < ApplicationRecord
  validates :street, presence: true
  validates :number, presence: true
  validates :neighborhood, presence: true

  belongs_to :addressable, polymorphic: true

  def full
    "#{street}, #{number}, #{neighborhood} - #{city} / #{state.upcase[0..1]}"
  end

  def self.update_or_create(addressable, params)
    if addressable.address
      addressable.address.update!(params)
    else
      Address.create!(params)
    end
  end
end
