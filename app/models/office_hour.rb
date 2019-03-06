class OfficeHour < ApplicationRecord
  belongs_to :service
  enum week_day: %i[segunda terça quarta quinta sexta sabado domingo]

  validates :week_day, presence: true
  validates :hour_begin, presence: true
  validates :hour_end, presence: true

  validate :hour_length
  validate :end_and_begin_hour
  validate :during_hour_work

  private

  def hour_length
    errors.add(:hour_begin, 'Verifique o horario de inicio') if hour_begin > 2359
    errors.add(:hour_end, 'Verifique o horario de término') if hour_end > 2359
  end

  def during_hour_work
    errors.add(:hour_end, 'Seu horário está inválido') if hour_end <= end_work
    self.hour_begin = end_work if hour_begin < end_work
  end

  def end_and_begin_hour
    errors.add(:hour_end, 'Seu horário é inválido') if hour_end < hour_begin
    errors.add(:hour_end, 'Seu horário é inválido') if hour_end == hour_begin
    errors.add(:hour_begin, 'Seu horário é inválido') if hour_begin > hour_end
  end

  def end_work
    @end_work ||= service.office_hours.where(week_day: week_day).order(hour_end: :desc).first&.hour_end || 0
  end
end
