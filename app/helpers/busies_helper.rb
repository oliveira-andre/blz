# frozen_string_literal: true

module BusiesHelper
  def duration_busy_range
    duration_busy_range = duration_service_range
    duration_busy_range << ['1 dia', 1440]
    duration_busy_range << ['3 dia', 4320]
    duration_busy_range << ['1 semana', 10_080]
    duration_busy_range << ['2 semanas', 20_160]
    duration_busy_range << ['1 mês', 43_200]
    duration_busy_range
  end
end
