module ApplicationHelper
  def mask_hour(value)
    value = "#{value.to_s[0, 2]}:#{value.to_s[2, 2]}" if value.to_s.length == 4
    value = "0#{value.to_s[0, 1]}:#{value.to_s[1, 2]}" if value.to_s.length == 3
    value = "00:#{value.to_s[0, 2]}" if value.to_s.length == 2
    value = "00:0#{value.to_s[0, 1]}" if value.to_s.length == 1
    value
  end
end
