module ApplicationHelper
  include Pagy::Frontend

  def week_day(date_time)
    I18n.l(date_time, format: :week_day)
  end

  def time(date_time)
    I18n.l(date_time, format: :time)
  end

  def day_month(date_time)
    I18n.l(date_time, format: :day_month)
  end

  def date_past?(date)
    date < (Time.now.utc - 4.hours)
  end

  def mask_hour(value)
    value = "#{value.to_s[0, 2]}:#{value.to_s[2, 2]}" if value.to_s.length == 4
    value = "0#{value.to_s[0, 1]}:#{value.to_s[1, 2]}" if value.to_s.length == 3
    value = "00:#{value.to_s[0, 2]}" if value.to_s.length == 2
    value = "00:0#{value.to_s[0, 1]}" if value.to_s.length == 1
    value
  end

  def establishment?
    !current_user.establishment.nil?
  end

  def default_image_service(service, size: '')
    "/images/default_category#{service.category.order}#{size}.jpg"
  end

  def self_employed?
    current_user.establishment.self_employed?
  end

  def valid_public_key
    Rails.application.credentials[Rails.env.to_sym][:vapid][:public_key]
  end

  def scheduling_status
    Scheduling.statuses.map do |status|
      [I18n.t("activerecord.enums.scheduling.#{status.first}"),
       status.first]
    end
  end
end
