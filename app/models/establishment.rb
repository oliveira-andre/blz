class Establishment < ApplicationRecord
  enum status: %i[authorization analyze approved disapproved canceled]

  validates :name, presence: true
  validates :timetable, presence: true
  validates :user_id, uniqueness: true

  belongs_to :user

  has_many :services
  has_many :professionals
  has_one :address, as: :addressable
  has_one_attached :photo

  accepts_nested_attributes_for :address, allow_destroy: true
  accepts_nested_attributes_for :user, allow_destroy: true

  after_create :create_moip_account, unless: :exist_moip_account?

  def scheduling
    professional_services_ids = ProfessionalService.where(
      professional_id: professionals.ids,
      service_id: services.ids
    ).ids.uniq
    ::Scheduling.where(professional_service_id: professional_services_ids)
                .where.not(status: %i[not_paid finished canceled])
                .order(:date)
  end

  def moip_update(moip_response)
    update(
      moip_account_id: moip_response.moip_account.id,
      moip_access_token: moip_response.access_token,
      moip_refresh_token: moip_response.refresh_token,
      moip_set_password_link: nil,
      status: :analyze
    )
  end

  private

  def exist_moip_account?
    Moip::Account::ExistService.execute(
      tax_document: user.cpf,
      email: user.email
    )
  end

  def create_moip_account
    Moip::Account::CreateService.execute self
  end
end
