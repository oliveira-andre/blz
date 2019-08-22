# frozen_string_literal: true

class Scheduling < ApplicationRecord
  default_scope { order(:date) }
  scope :history, -> { where.not(status: :scheduled) }

  enum status: %i[analyze scheduled finished canceled busy recused]
  enum canceled_by: %i[user establishment]

  belongs_to :user, required: false
  belongs_to :professional_service

  has_one :service, through: :professional_service
  has_one :professional, through: :professional_service
  has_one :address, as: :addressable
  has_one :review, as: :reviewable
  has_one :report_problem, as: :reportable

  before_validation :set_service_duration, unless: :busy?

  validates :status, presence: true
  validates :date, presence: true
  validates :service_duration, presence: true
  validates :in_home, inclusion: { in: [true, false] }, unless: :busy?

  validates_with DatePastValidator, on: :create

  validate :date_in_schedule?, on: :create, unless: :busy?
  validate :user_date_busy?, on: :create, unless: :busy?
  validate :professional_date_busy?, on: :create, unless: :busy?
  validate :service_approved?, on: :create, unless: :busy?
  validate :user_registration_ok?, on: :create
  validate :verify_finishing
  validate :cancel_fields
  validate :verify_canceling
  validate :verify_in_home, unless: :busy?
  validate :verify_accepting
  validate :verify_recusing

  after_create :set_schedule_busy
  after_save :block_user
  after_save :set_schedule_free
  after_save :cancel_notification
  after_save :accepted_notification
  after_save :recused_notification
  after_create :notifications

  accepts_nested_attributes_for :address, allow_destroy: true,
                                          reject_if: :in_establishment?

  private

  def date_in_schedule?
    schedule = professional_service.schedules.where(date: date).first
    return unless schedule.nil?

    @errors.add(:date, 'inválido ou indisponível, tente novamente')
  end

  def professional_date_busy?
    professional_services_ids = professional.professional_services.ids

    schedulings = Scheduling.where(
      professional_service_id: professional_services_ids,
      status: %i[scheduled busy analyze]
    )

    schedulings.each do |s|
      date_start = s.date
      date_finish = s.date + s.service_duration.minutes - 1.second

      if date.between?(date_start, date_finish) ||
         (date + service_duration.minutes).between?(date_start, date_finish)
        @errors.add(:date, 'já esta ocupado para esse salão/profissional')
      end
    end
  end

  def user_date_busy?
    scheduling_ids = user.scheduling.where(
      date: (date..(date + service_duration.minutes - 1.second)),
      status: %i[scheduled analyze]
    ).ids

    return if scheduling_ids.empty?

    @errors.add(:date, 'já esta ocupado na sua agenda')
  end

  def service_approved?
    return if service.approved?

    @errors.add(:professional_service, 'não esta disponível')
  end

  def user_registration_ok?
    return if busy? || user.registration_ok?

    @errors.add(:user, 'não está com o cadastro completo')
  end

  def verify_finishing
    return unless finished?

    unless Time.now > date
      @errors.add(:scheduling, 'não pode ser finalizado antes a data combinada')
    end
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

  def verify_canceling
    return unless canceled?

    if Time.now > date
      @errors.add(:scheduling, 'não pode ser cancelado após a data combinada')
    end
  end

  def verify_in_home
    if in_home? && service.establishment?
      @errors.add(:service, 'não permite essa localidade')
    elsif in_establishment? && service.home?
      @errors.add(:service, 'não permite essa localidade')
    end
  end

  def verify_accepting
    return unless scheduled?

    if Time.now > date
      @errors.add(:scheduling, 'não pode ser aceito após a data combinada')
    end
  end

  def verify_recusing
    return unless recused?

    if Time.now > date
      @errors.add(:scheduling, 'não pode ser recusado após a data combinada')
    end
  end

  def set_schedule_busy
    professional.professional_services.each do |ps|
      start_date = date - (ps.service.duration.minutes - 1.minute)
      end_date = date + (service_duration.minutes - 1.minute)
      ps.schedules.where(date: (start_date..end_date)).update_all(free: false)
    end
  end

  def set_service_duration
    self.service_duration = service.duration
  end

  def block_user
    return if establishment?

    user.blocked! if canceled? && canceled_at > (date - 4.hours)
  end

  def set_schedule_free
    return unless canceled?

    professional.professional_services.each do |ps|
      start_date = date - (ps.service.duration.minutes - 1.minute)
      end_date = date + (service_duration.minutes - 1.minute)
      ps.schedules.where(date: (start_date..end_date)).update_all(free: true)
    end
  end

  def cancel_notification
    return unless canceled? && user?

    CanceledSchedulingMailer.to_establishment(self).deliver_later
    CanceledSchedulingMailer.to_user(self).deliver_later
  end

  def notifications
    return if busy?

    SchedulingMailer.to_establishment(self).deliver_later
    NotificationBroadcastJob.perform_later(self)
  end

  def accepted_notification
    return unless scheduled?

    AcceptedSchedulingMailer.to_establishment(self).deliver_later
    AcceptedSchedulingMailer.to_user(self).deliver_later
  end

  def recused_notification
    return unless recused?

    RecusedSchedulingMailer.to_establishment(self).deliver_later
    RecusedSchedulingMailer.to_user(self).deliver_later
  end

  def in_establishment?
    !in_home?
  end
end
