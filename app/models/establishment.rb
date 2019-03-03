class Establishment < ApplicationRecord
  belongs_to :user

  validates :cpf_cnpj, presence: true
  validates :name, presence: true
  validates :email, presence: true
  validates :phone, presence: true
  validates :timetable, presence: true

  validates :user_id, uniqueness: true

  has_many :services
  has_one_attached :photo
end
