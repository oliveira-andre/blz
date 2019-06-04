class Establishment < ApplicationRecord
  enum status: %i[analyze approved disapproved canceled]
  enum self_employed: { altonomo: true, estabelecimento: false }

  validates :name, presence: true
  validates :timetable, presence: true
  validates :user_id, uniqueness: true

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
    ::Scheduling.where(professional_service_id: professional_services_ids)
                .scheduled.order(:date)
  end
end
