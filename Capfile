# frozen_string_literal: true

require 'capistrano/setup'
require 'capistrano/deploy'
require 'capistrano/scm/git'
require 'capistrano/rails'
# require 'capistrano/rvm'
require 'capistrano/rbenv'
require 'capistrano/puma'
require 'capistrano/yarn'
require 'capistrano/sidekiq'
require 'whenever/capistrano'
require 'capistrano/dotenv/tasks'

install_plugin Capistrano::SCM::Git
install_plugin Capistrano::Puma
install_plugin Capistrano::Puma::Workers
install_plugin Capistrano::Puma::Nginx
Dir.glob('lib/capistrano/tasks/*.rake').each { |r| import r }
