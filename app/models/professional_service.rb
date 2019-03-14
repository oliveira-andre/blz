class ProfessionalService < ApplicationRecord
  belongs_to :professional
  belongs_to :service

  has_many :schedules
  has_many :office_hours
end
