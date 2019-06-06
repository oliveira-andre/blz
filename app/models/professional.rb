class Professional < ApplicationRecord
  belongs_to :establishment
  has_many :professional_services
  has_many :office_hours
  has_one_attached :photo

  validate :self_employed_restriction, on: :create

  private

  def self_employed_restriction
    return if establishment.self_employed?

    errors.add(:base, 'Profissional autônomo e só pode cadastrar 1 profissional.')
  end
end
