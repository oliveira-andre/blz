# frozen_string_literal: true

require 'open-uri'

class User < ApplicationRecord
  scope :no_establishment, -> { where.not(id: establishement_users_ids) }

  enum profile: %i[common admin]
  enum status: %i[active blocked]

  devise :database_authenticatable, :registerable, :recoverable, :rememberable,
         :validatable, :trackable, :omniauthable, :confirmable,
         omniauth_providers: [:facebook]

  validates :name, presence: true
  validates :birth_date, presence: true, unless: :skip_validation_to_user?
  validates :phone, presence: true, unless: :skip_validation_to_user?
  validates :terms_acceptation, presence: true
  validates :email, presence: true, uniqueness: true
  validates :cpf, presence: true, unless: :skip_validation_to_user?
  validates_cpf :cpf, unless: :skip_validation_to_user?
  validates :cpf, uniqueness: true, unless: :skip_validation_to_user?

  validate :photo_type, unless: :skip_validation_to_user?
  validate :cpf_change, on: :update

  has_many :scheduling
  has_many :payment_cards
  has_one :establishment
  has_one :address, as: :addressable
  has_one_attached :photo

  accepts_nested_attributes_for :address, allow_destroy: true

  def self.search(search)
    where('name ILIKE ?', "%#{search}%")
  end

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.name = auth.info.name
      user.password = Devise.friendly_token[0, 20]
      user.terms_acceptation = true
      downloaded_image = open(auth.info.image) if auth.info.image.present?

      if downloaded_image
        user.photo.attach(
          io: downloaded_image,
          filename: 'avatar.jpg',
          content_type: downloaded_image.content_type
        )
      end
    end
  end

  def registration_ok?
    cpf.present? && phone.present? && birth_date.present?
  end

  def cpf_change
    errors.add(:cpf, 'Não pode ser atualizado') if cpf_changed? && User.find(id).cpf.present?
  end

  def self.establishement_users_ids
    Establishment.all.pluck(:user_id)
  end

  private

  def skip_validation_to_user?
    return true if reset_password_token?
    return true if establishment.nil? && id.nil?

    false
  end

  def photo_type
    errors.add(:photo, 'com formato inválido') if photo.attached? && !photo.content_type.in?(%(image/jpeg image/png))
  end
end
