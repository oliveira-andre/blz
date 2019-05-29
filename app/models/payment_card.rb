class PaymentCard < ApplicationRecord
  enum status: %i[active inactive]

  belongs_to :user

  validates :brand, presence: true
  validates :hash, presence: true
  validates :moip_card_id, presence: true, uniqueness: { scope: :user_id }
  validates :expiration_month, presence: true
  validates :expiration_year, presence: true
  validates :number, presence: true, uniqueness: { scope: :user_id }
  validates :holder_name, presence: true
  validates :holder_cpf, presence: true
  validates :holder_birth_date, presence: true
  validates_cpf :holder_cpf
end
