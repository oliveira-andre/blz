module ApplicationHelper
  def week_day(date_time)
    I18n.l(date_time, format: :week_day)
  end

  def time(date_time)
    I18n.l(date_time, format: :time)
  end

  def day_month(date_time)
    I18n.l(date_time, format: :day_month)
  end
end
