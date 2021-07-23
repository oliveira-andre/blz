# frozen_string_literal: true

module PaymentsHelper
  ESTADOS_BRASILEIROS = [
    %w[Rondônia RO],
    %w[Acre AC],
    %w[Alagoas AL],
    %w[Amapá AP],
    %w[Amazonas AM],
    %w[Bahia BA],
    %w[Ceará CE],
    ['Distrito Federal', 'DF'],
    ['Espírito Santo', 'ES'],
    %w[Goiás GO],
    %w[Maranhão MA],
    ['Mato Grosso', 'MT'],
    ['Mato Grosso do Sul', 'MS'],
    ['Minas Gerais', 'MG'],
    %w[Pará PA],
    %w[Paraíba PB],
    %w[Paraná PR],
    %w[Pernambuco PE],
    %w[Piauí PI],
    ['Rio de Janeiro', 'RJ'],
    ['Rio Grande do Norte', 'RN'],
    ['Rio Grande do Sul', 'RS'],
    %w[Roraima RR],
    ['Santa Catarina', 'SC'],
    ['São Paulo', 'SP'],
    %w[Sergipe SE],
    %w[Tocantins TO]
  ].freeze

  def render_states(name)
    select_tag(name, options_for_select(ESTADOS_BRASILEIROS))
  end

  def credit_card_expiration_year_range
    (Time.now.strftime('%y').to_i..(Time.now.strftime('%y').to_i + 15)).to_a
  end

  def birthdate_year_range
    ((Time.now.year - 80)..(Time.now.year - 15)).to_a.reverse
  end
end
