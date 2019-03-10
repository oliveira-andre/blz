class Scheduling < ApplicationRecord
  scope :history, -> { where.not(status: %i[in_payment awaiting_service]) }

  enum status: %i[in_payment awaiting_service finished canceled]

  belongs_to :user, required: false
  belongs_to :service

  validates :status, presence: true
  validates :begin_time, presence: true
  validates :end_time, presence: true

  validates_with DatePastValidator

  validate :uniqueness_time_by_user
  validate :uniqueness_time_by_establishment

  private

  def uniqueness_time_by_establishment
    return if service_id.nil?

    current_establishment = service.establishment
    services_ids_by_establishment = current_establishment.services.ids
    scheduling_ids = Scheduling.where(
      end_time: (begin_time..end_time),
      service_id: services_ids_by_establishment
    ).ids

    return if scheduling_ids.empty?

    @errors.add(:begin_time, 'já esta ocupado para esse salão/profissional')
  end

  def uniqueness_time_by_user
    return if user_id.nil?

    scheduling_ids = Scheduling.where(
      end_time: (begin_time..end_time),
      user_id: user_id
    ).ids

    return if scheduling_ids.empty?

    @errors.add(:begin_time, 'já esta ocupado na sua agenda')
  end
end
