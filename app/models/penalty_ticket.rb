# frozen_string_literal: true

class PenaltyTicket < ApplicationRecord
  enum kind: %i[canceled missed]
  enum status: %i[created waiting paid not_paid reverted]

  belongs_to :scheduling

  validates :amount, presence: true
end
