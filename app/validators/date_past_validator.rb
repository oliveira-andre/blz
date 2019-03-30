class DatePastValidator < ActiveModel::Validator
  def validate(record)
    @record = record
    return unless @record.date.present?
    return if @record.date >= Time.zone.now

    @record.errors.add(:date, 'não pode ser no passado')
  end
end
