class User < ApplicationRecord
  enum profile: %i[common admin]
  enum status: %i[active blocked]

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable

  validates :name, presence: true
  validates :birth_date, presence: true, if: :establishment_or_update?
  validates :phone, presence: true, if: :establishment_or_update?
  validates :terms_acceptation, presence: true
  validates :email, presence: true, uniqueness: true
  validates :cpf, presence: true,
                  if: :establishment_or_update?
  validates_cpf :cpf, if: :establishment_or_update?
  validates :cpf, uniqueness: true, unless: :user_register?

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
    end
  end

  def establishment_or_update?
    !establishment.nil? || !id.nil?
  end

  private

  def user_register?
    establishment.nil? && id.nil?
  end
end
