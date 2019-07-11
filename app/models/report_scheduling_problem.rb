class ReportSchedulingProblem < ApplicationRecord
  enum category: %i[not_appear bad_treatment]

  belongs_to :user

  validates :category, presence: true
end
