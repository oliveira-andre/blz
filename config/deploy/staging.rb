# frozen_string_literal: true

set :branch, 'master'
set :server_address, '34.95.219.48'
ask(:password, nil, echo: false)
server fetch(:server_address), user: 'deploy', roles: %w[app db web]
set :nginx_server_name, fetch(:server_address)
set :puma_preload_app, true

append :linked_files, '.env.production.local'
set :rbenv_type, :system
set :rbenv_ruby, '2.6.1'
