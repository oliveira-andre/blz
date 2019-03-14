class Professional < ApplicationRecord
	belongs_to :establishment

	has_one_attached :photo

	has_many :professional_services

end
