# frozen_string_literal: true

module EstablishmentsDashboardHelper
  def establishment_professionals_collection(establishment)
    establishment.professionals.collect do |professional|
      [professional.name.capitalize, professional.id]
    end
  end
end
