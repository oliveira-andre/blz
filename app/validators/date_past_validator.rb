# frozen_string_literal: true

class DatePastValidator < ActiveModel::Validator
  def validate(record)
    @record = record
    return unless @record.date.present?
    return if @record.date >= (Time.now.utc - 4.hours)

    @record.errors.add(:date, 'não pode ser no passado')
  end
end
