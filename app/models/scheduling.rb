# frozen_string_literal: true

class Scheduling < ApplicationRecord
  default_scope { order(:date) }
  scope :history, -> { where.not(status: :scheduled) }

  enum status: %i[scheduled finished canceled]
  enum canceled_by: %i[user establishment]

  belongs_to :user, required: false
  belongs_to :professional_service

  has_one :review, as: :reviewable
  has_one :service, through: :professional_service
  has_one :professional, through: :professional_service

  before_validation :set_service_duration

  validates :status, presence: true
  validates :date, presence: true
  validates :service_duration, presence: true

  validates_with DatePastValidator

  validate :date_in_schedule?, on: :create
  validate :user_date_busy?, on: :create
  validate :professional_date_busy?, on: :create
  validate :service_approved?, on: :create
  validate :user_registration_ok?, on: :create
  validate :cancel_fields

  after_save :set_schedule_busy
  after_save :block_user
  after_create :notifications

  private

  def date_in_schedule?
    schedule = professional_service.schedules.where(date: date).first
    return unless schedule.nil?

    @errors.add(:date, 'inválido ou indisponível, tente novamente')
  end

  def professional_date_busy?
    professional_services_ids = professional.professional_services.ids

    scheduling_ids = Scheduling.where(
      professional_service_id: professional_services_ids,
      date: (date..(date + service_duration.minutes - 1.seconds))
    )

    return if scheduling_ids.empty?

    @errors.add(:date, 'já esta ocupado para esse salão/profissional')
  end

  def user_date_busy?
    scheduling_ids = user.scheduling.where(
      date: (date..(date + service_duration.minutes - 1.seconds))
    ).ids

    return if scheduling_ids.empty?

    @errors.add(:date, 'já esta ocupado na sua agenda')
  end

  def service_approved?
    return if service.approved?

    @errors.add(:professional_service, 'não esta disponível')
  end

  def user_registration_ok?
    return if user.registration_ok?

    @errors.add(:user, 'não está com o cadastro completo')
  end

  def cancel_fields
    return unless canceled?

    if !canceled_reason || canceled_reason.blank?
      @errors.add(:canceled_reason, 'não pode ficar em branco')
    end

    if !canceled_at || canceled_at.blank?
      @errors.add(:canceled_at, 'não pode ficar em branco')
    end

    if !canceled_by || canceled_by.blank?
      @errors.add(:canceled_by, 'não pode ficar em branco')
    end
  end

  def set_schedule_busy
    schedule = professional_service.schedules.where(date: date).first
    schedule.update! free: false
  end

  def set_service_duration
    self.service_duration = service.duration
  end

  def block_user
    return if establishment?
  end

  def notifications
    SchedulingMailer.to_user(self).deliver_later
    SchedulingMailer.to_establishment(self).deliver_later
    NotificationBroadcastJob.perform_later(self)
  end
end
