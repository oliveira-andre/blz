# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

gem 'autocomplete_zipcode'
gem 'bootsnap', '>= 1.1.0', require: false
gem 'devise'
gem 'dotenv-rails'
gem 'jbuilder', '~> 2.5'
gem 'jquery_mask_rails'
gem 'mini_magick'
gem 'moip2'
gem 'omniauth'
gem 'omniauth-facebook'
gem 'omniauth-google-oauth2'
gem 'pagy'
gem 'pg', '>= 0.18', '< 2.0'
gem 'puma', '~> 3.11'
gem 'pundit'
gem 'rack-cors', require: 'rack/cors'
gem 'rails', '~> 5.2.2'
gem 'redis'
gem 'route_translator'
gem 'sass-rails', '~> 5.0'
gem 'sentry-raven'
gem 'serviceworker-rails'
gem 'sidekiq'
gem 'toastr-rails'
gem 'turbolinks', '~> 5'
gem 'uglifier', '>= 1.3.0'
gem 'validates_cpf_cnpj'
gem 'webpacker'
gem 'webpush'
gem 'whenever', require: false

group :development, :test do
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'capistrano-dotenv-tasks', require: false
  gem 'database_cleaner'
  gem 'factory_bot_rails'
  gem 'ffaker'
  gem 'rspec-rails'
  gem 'rubocop'
  gem 'shoulda-matchers'
end

group :development do
  gem 'capistrano', '~> 3.10', require: false
  gem 'capistrano3-puma', require: false
  gem 'capistrano-rails', '~> 1.3', require: false
  gem 'capistrano-rbenv', '~> 2.1', require: false
  gem 'capistrano-rvm', require: false
  gem 'capistrano-sidekiq'
  gem 'capistrano-yarn'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'pry-rails'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'web-console', '>= 3.3.0'
end

group :test do
  gem 'database_cleaner'
  gem 'factory_bot_rails'
  gem 'ffaker'
  gem 'rails-controller-testing'
  gem 'rspec-rails'
end

gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
