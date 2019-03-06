class DatePastValidator < ActiveModel::Validator
  def validate(record)
    @record = record
    return unless @record.begin_time.present?
    return unless @record.begin_time >= Time.zone.now

    @record.errors.add(:begin_time, 'não pode ser no passado')
  end
end
