module RemoveSpecialCharacter
  extend ActiveSupport::Concern
  def hour_begin=(value)
    super(value.delete(':')) unless value.blank?
  end

  def hour_end=(value)
    super(value.delete(':')) unless value.blank?
  end
end