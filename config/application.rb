require_relative 'boot'

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "active_storage/engine"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
require "action_cable/engine"
require "sprockets/railtie"
# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Blz
  class Application < Rails::Application
    config.load_defaults 5.2
    config.i18n.default_locale = 'pt-BR'
    config.generators.system_tests = nil
    config.generators.assets = false
    config.generators.helper = false
    config.active_job.queue_adapter = :sidekiq
    config.active_record.default_timezone = :local

    Raven.configure do |config|
      config.dsn = ENV.fetch('SENTRY_DSN')
    end
  end
end
