# config valid for current version and patch releases of Capistrano
lock "~> 3.16.0"

# Change these
server '167.99.224.148', port: 22, roles: [:web, :app], primary: true

set :repo_url,        'git@github.com:kolyastepanets/record_expances_google_sheet.git'
set :application,     'record_expenses_google_sheet'
set :user,            'root'
set :puma_threads,    [4, 16]
set :puma_workers,    0

# Don't change these unless you know what you're doing
set :pty,             true
set :use_sudo,        false
set :stage,           :production
set :deploy_via,      :remote_cache
set :deploy_to,       "/home/#{fetch(:user)}/apps/#{fetch(:application)}"
set :puma_bind,       "unix://#{shared_path}/tmp/sockets/#{fetch(:application)}-puma.sock"
set :puma_state,      "#{shared_path}/tmp/pids/puma.state"
set :puma_pid,        "#{shared_path}/tmp/pids/puma.pid"
set :puma_access_log, "#{release_path}/log/puma.error.log"
set :puma_error_log,  "#{release_path}/log/puma.access.log"
set :ssh_options,     { forward_agent: true, user: fetch(:user), keys: %w(~/.ssh/id_rsa_github.pub) }
set :puma_preload_app, true
set :puma_worker_timeout, nil
set :puma_init_active_record, true  # Change to false when not using ActiveRecord

set :rvm_ruby_version, "ruby-3.3.0@teg_bot_rec_exp_google_sheet"
set :default_env, { rvm_bin_path: "~/.rvm/bin" }

set :default_environment, {
  'PATH' => "/usr/share/rvm/gems/ruby-3.3.0@teg_bot_rec_exp_google_sheet/bin:/usr/share/rvm/gems/ruby-3.3.0@global/bin:/usr/share/rvm/rubies/ruby-3.3.0/bin:/usr/share/rvm/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin",
  'RUBY_VERSION' => 'ruby-3.3.0',
  'GEM_HOME'     => '/usr/share/rvm/gems/ruby-3.3.0@teg_bot_rec_exp_google_sheet',
  'GEM_PATH'     => '/usr/share/rvm/gems/ruby-3.3.0@teg_bot_rec_exp_google_sheet',
  'BUNDLE_PATH'  => '/usr/share/rvm/gems/ruby-3.3.0@teg_bot_rec_exp_google_sheet/bin/bundle'  # If you are using bundler.
}

# skip assets:precompile
set :assets_roles, []

## Defaults:
# set :scm,           :git
# set :branch,        :master
# set :format,        :pretty
# set :log_level,     :debug
# set :keep_releases, 5

## Linked Files & Directories (Default None):
# set :linked_files, %w{config/database.yml}
# set :linked_dirs,  %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}
set :linked_files, %w[config/database.yml config/application.yml]

set :whenever_identifier, -> { "#{fetch(:application)}_#{fetch(:stage)}" }

namespace :puma do
  desc 'Create Directories for Puma Pids and Socket'
  task :make_dirs do
    on roles(:app) do
      execute "mkdir #{shared_path}/tmp/sockets -p"
      execute "mkdir #{shared_path}/tmp/pids -p"
    end
  end

  before :start, :make_dirs
end

namespace :deploy do
  desc "Make sure local git is in sync with remote."
  task :check_revision do
    on roles(:app) do
      unless `git rev-parse HEAD` == `git rev-parse origin/master`
        puts "WARNING: HEAD is not the same as origin/master"
        puts "Run `git push` to sync changes."
        exit
      end
    end
  end

  desc 'Initial Deploy'
  task :initial do
    on roles(:app) do
      before 'deploy:restart', 'puma:start'
      invoke 'deploy'
    end
  end

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      invoke 'puma:restart'
    end
  end

  desc "Update crontab with whenever"
  task :update_cron do
    on roles(:app) do
      within current_path do
        execute :bundle, :exec, "whenever -c #{fetch(:application)}"
        execute :bundle, :exec, "whenever -w #{fetch(:application)}"
      end
    end
  end

  before :starting,     :check_revision
  after  :finishing,    :compile_assets
  after  :finishing,    :cleanup
  after  :finishing,    :restart
  after  :finishing,    :update_cron
end

namespace :sidekiq do
  task :quiet do
    on roles(:app) do
      puts capture("pgrep -f 'sidekiq' | xargs kill -TSTP")
    end
  end
  task :restart do
    on roles(:app) do
      execute :sudo, :systemctl, :restart, :sidekiq
    end
  end
end

after 'deploy:starting', 'sidekiq:quiet'
after 'deploy:reverted', 'sidekiq:restart'
after 'deploy:published', 'sidekiq:restart'

# ps aux | grep puma    # Get puma pid
# kill -s SIGUSR2 pid   # Restart puma
# kill -s SIGTERM pid   # Stop puma
