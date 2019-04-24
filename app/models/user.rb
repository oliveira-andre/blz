class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable

  validates :name, presence: true
  validates :birth_date, presence: true, if: :establishment_or_update?
  validates :phone, presence: true, if: :establishment_or_update?
  validates :terms_acceptation, presence: true
  validates :email, presence: true, uniqueness: true
  validates :cpf, presence: true,
                  uniqueness: true,
                  if: :establishment_or_update?
  validates_cpf :cpf, if: :establishment_or_update?

  has_many :scheduling
  has_one :establishment
  has_one :address, as: :addressable
  has_many :scheduling

  accepts_nested_attributes_for :address, allow_destroy: true

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.name = auth.info.name
      user.password = Devise.friendly_token[0, 20]
    end
  end

  def establishment_or_update?
    !establishment.nil? || !id.nil?
  end
end
