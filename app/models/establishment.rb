# frozen_string_literal: true

class Establishment < ApplicationRecord
  enum status: %i[analyze approved disapproved canceled]

  after_save :analyze_services
  after_create :send_registration_success

  validates :name, presence: true
  validates :timetable, presence: true
  validates :user_id, uniqueness: true
  validate :photo_type

  belongs_to :user

  has_many :services, -> { order(:status) }
  has_many :professionals
  has_one :address, as: :addressable
  has_one_attached :photo

  accepts_nested_attributes_for :address, allow_destroy: true
  accepts_nested_attributes_for :user, allow_destroy: true

  def scheduling
    professional_services_ids = ProfessionalService.where(
      professional_id: professionals.ids,
      service_id: services.ids
    ).ids.uniq

    Scheduling.where(
      professional_service_id: professional_services_ids,
      status: %i[scheduled analyze]
    ).order(:date).reorder(:status)
  end

  def self.search(query)
    where('name ILIKE ?', "%#{query}%")
  end

  private

  def analyze_services
    services&.each { |service| service.awaiting_avaliation! } unless approved?
  end

  def send_registration_success
    #EstablishmentMailer.registration_success(self).deliver_later
  end

  def photo_type
    errors.add(:photo, 'com formato inválido') if photo.attached? && !photo.content_type.in?(%(image/jpeg image/png))
  end
end
