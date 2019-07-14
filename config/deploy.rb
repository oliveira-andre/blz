lock "~> 3.11.0"

set :application, "blz"
set :repo_url, "git@gitlab.com:blz/blz.git"

set :deploy_to, "/var/www/blz"
append :linked_dirs, "log", "tmp"
set :keep_releases, 5
set :migration_role, :app
set :rails_env, :production
set :puma_pid, "#{shared_path}/tmp/pids/puma.pid"
set :puma_bind, "unix://#{shared_path}/tmp/sockets/puma.sock"
set :puma_access_log, "#{shared_path}/log/puma_access.log"
set :puma_error_log, "#{shared_path}/log/puma_error.log"
set :nginx_sites_available_path, "/etc/nginx/sites-available"
set :nginx_sites_enabled_path, "/etc/nginx/sites-enabled"

namespace :puma do
  desc 'Create Puma dirs'
  task :create_dirs do
    on roles(:app) do
      execute "mkdir #{shared_path}/tmp/sockets -p"
      execute "mkdir #{shared_path}/tmp/pids -p"
    end
  end

  desc 'Restart puma systemctl'
  task :systemctl_restart do
    on roles(:app) do
      execute 'sudo systemctl restart blzpuma.service'
    end
  end

  desc "Restart Nginx"
  task :nginx_restart do
    on roles(:app) do
      execute "sudo service nginx restart"
    end
  end

  before :start, :create_dirs
  after :start, :systemctl_restart
  after :start, :nginx_restart
end
