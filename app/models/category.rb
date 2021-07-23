# frozen_string_literal: true

class Category < ApplicationRecord
  validates :name, presence: true
  validates :description, presence: true
end
