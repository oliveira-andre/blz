# frozen_string_literal: true

module EstablishmentsDashboardHelper
  def establishment_professionals(establishment)
    select(:establishment, :professionals,
           establishment.professionals.collect do |professional|
             [professional.name.capitalize, professional.id]
           end)
  end
end
