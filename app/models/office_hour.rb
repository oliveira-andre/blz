class OfficeHour < ApplicationRecord
  include RemoveSpecialCharacter

  belongs_to :service
  enum week_day: %i[segunda terça quarta quinta sexta sabado domingo]

  validates :week_day, presence: true
  validates :hour_begin, presence: true
  validates :hour_end, presence: true

  validate :hour_length

  def hour_length
    errors.add(:hour_begin, "Verifique o horario de inicio") if hour_begin > 2359
    errors.add(:hour_begin, "Seu horário é inválido") if hour_begin > hour_end
    errors.add(:hour_end, "Verifique o horario de término") if hour_end > 2359
    errors.add(:hour_end, "Seu horário é inválido") if hour_end < hour_begin
    errors.add(:hour_end, "Seu horário é inválido") if hour_end == hour_begin
  end
end
