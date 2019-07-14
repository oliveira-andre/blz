set :branch, 'qa'
set :server_address, 'qa.blz.life'


ask(:password, nil, echo: false)
server fetch(:server_address), user: "deploy", roles: %w{app db web} 
set :nginx_server_name, fetch(:server_address)
set :puma_preload_app, true

append :linked_files, '.env.production.local'
set :rvm_ruby_version, '2.6.1'