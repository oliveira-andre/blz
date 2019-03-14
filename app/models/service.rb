class Service < ApplicationRecord
  enum status: %i[approved recused awaiting_avaliation archived]
  enum local_type: %i[home establishment]

  has_many_attached :photos

  belongs_to :category
  belongs_to :establishment

  has_many :office_hours
  has_many :linked_services

  validates :title, presence: true
  validates :description, presence: true
  validates :amount, presence: true
  validates :duration, presence: true
  validates :local_type, presence: true
  validates :status, presence: true

  validates :title, uniqueness: { scope: :establishment_id }

  def links_with_services
    services_ids = linked_services.pluck(:linked_id) << id
    LinkedService.where(service_id: services_ids, linked_id: services_ids).uniq
  end
end
