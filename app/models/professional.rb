class Professional < ApplicationRecord
  belongs_to :establishment
  has_many :professional_services
  has_many :office_hours
  has_one_attached :photo

  validate :self_employed_restriction, on: :create

  private

  def self_employed_restriction
    if establishment.self_employed == true
      errors.add(:base, 'Apenas um profissional!')
    end
  end
end
