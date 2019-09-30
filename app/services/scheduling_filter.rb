# frozen_string_literal: true

module SchedulingFilter
  class << self
    def execute(status, date, current_user)
      @current_user = if current_user.establishment.present?
                        current_user.establishment
                      else
                        current_user
                      end
      schedulings = @current_user.scheduling
      schedulings.where!(status: status.to_sym) if status.present?
      schedulings.where!(date: apply_date_filter(date)) if date.present?
      schedulings = @current_user.scheduling if schedulings.empty?
      schedulings
    end

    def apply_date_filter(date)
      t = (Time.now - 4.hours)
      if date == 'today'
        date_filter = "#{t.day}/#{t.month}/#{t.year}%"
      elsif date == 'week'
        t_week = (t - 7.days)
        date_filter = t..t_week
      elsif date == 'month'
        t_month = (t - 1.month)
        date_filter = t..t_month
      end
      date_filter
    end
  end
end
