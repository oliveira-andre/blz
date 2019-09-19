# frozen_string_literal: true

class View < ApplicationRecord
  belongs_to :viewable, polymorphic: true

  validates :viewable_count, presence: true,
                             numericality: { greater_than_or_equal_to: 1 }
end
