class Establishment < ApplicationRecord
  belongs_to :user

  validates :cpf_cnpj, presence: true
  validates :name, presence: true
  validates :email, presence: true
  validates :phone, presence: true
  validates :timetable, presence: true

  validates :user_id, uniqueness: true

  has_many :services
  has_many :professionals

  has_one :address
  has_one_attached :photo

  accepts_nested_attributes_for :address, allow_destroy: true,
                                          reject_if: :all_blank

  accepts_nested_attributes_for :user, allow_destroy: true,
                                       reject_if: :all_blank

  def scheduling
    professional_services_ids = ProfessionalService.where(
      professional_id: professionals.ids,
      service_id: services.ids
    ).uniq
    ::Scheduling.where(professional_service_id: professional_services_ids)
  end
end
