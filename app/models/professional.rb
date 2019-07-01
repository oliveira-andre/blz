# frozen_string_literal: true

class Professional < ApplicationRecord
  belongs_to :establishment
  has_many :professional_services, dependent: :destroy
  has_many :office_hours, dependent: :destroy
  has_one_attached :photo, dependent: :destroy

  validate :self_employed_restriction, on: :create
  validate :photo_type

  private

  def self_employed_restriction
    if establishment.self_employed? &&
       establishment.professionals.count.positive?

      errors.add(:self_employed, 'só pode cadastrar 1 profissional.')
    end
  end

  def photo_type
    if photo.attached? && !photo.content_type.in?(%(image/jpeg image/png))
      errors.add(:photo, 'com formato inválido')
    end
  end
end
