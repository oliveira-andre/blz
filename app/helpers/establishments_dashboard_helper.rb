# frozen_string_literal: true

module EstablishmentsDashboardHelper
  def establishment_professionals_collection(establishment)
    establishment.professionals.collect do |professional|
      [professional.name.capitalize, professional.id]
    end
  end

  def scheduling_status
    Scheduling.statuses.map do |status|
      [I18n.t("activerecord.enums.scheduling.#{status.first}"),
       status.first]
    end
  end
end
