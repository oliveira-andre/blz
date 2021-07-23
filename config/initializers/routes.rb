# frozen_string_literal: true

RouteTranslator.config do |config|
  config.available_locales = ['pt-BR']
  config.force_locale = true
  config.hide_locale = true
  config.locale_param_key = 'pt-BR'
  config.generate_unnamed_unlocalized_routes = true
end
