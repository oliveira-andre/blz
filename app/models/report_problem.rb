# frozen_string_literal: true

class ReportProblem < ApplicationRecord
  enum category: %i[not_appear bad_treatment]

  belongs_to :reportable, polymorphic: true
  belongs_to :user

  validates :category, presence: true
end
