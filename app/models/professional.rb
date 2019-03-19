class Professional < ApplicationRecord
  belongs_to :establishment
  has_many :professional_services
  has_many :office_hours
  has_one_attached :photo
end
