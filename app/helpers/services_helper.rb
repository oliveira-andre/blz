# frozen_string_literal: true

module ServicesHelper
  def duration_service_range
    duration_service_range = []
    (30..300).step(15).each do |i|
      hora = (i / 60.0).divmod 1
      minutos = (hora[1].round(2) * 60).floor
      if hora[0] < 1
        duration_service_range << ["#{i} m", i]
      else
        duration_service_range << ["#{hora[0]}h#{minutos}m", i]
      end
    end
    duration_service_range
  end

  def has_schedules_to_service(service)
    professional_services_ids = ProfessionalService.where(
      service_id: service.id
    ).ids

    Schedule.where(
      professional_service_id: professional_services_ids
    ).ids.any?
  end
end
