require "bundler/capistrano"

set :application,                 "aepokc"
set :scm,                         :git
set :repository,                  "git@github.com:aepokc/aepokc.git"
set :branch,                      "origin/master"
set :migrate_target,              :current
set :ssh_options,                 { :forward_agent => true }
set :rails_env,                   "production"
set :deploy_to,                   "/home/aepadmin/aepokc"
set :normalize_asset_timestamps,  false

set :user,                        "aepadmin"
set :group,                       "aepokc"
set :use_sudo,                    false

role :web,                        "198.101.242.247"
role :app,                        "198.101.242.247"
role :db,                         "198.101.242.247", :primary => true

set(:latest_release)  { fetch(:current_path) }
set(:release_path)    { fetch(:current_path) }
set(:current_release) { fetch(:current_path) }

set(:current_revision)  { capture("cd #{current_path}; git rev-parse --short HEAD").strip }
set(:latest_revision)   { capture("cd #{current_path}; git rev-parse --short HEAD").strip }
set(:previous_revision) { capture("cd #{current_path}; git rev-parse --short HEAD@{1}").strip }

default_environment["RAILS_ENV"]    = "production"
default_environment["PATH"]         = "/home/aepadmin/.rvm/gems/ruby-1.9.2-p320/bin:/home/aepadmin/.rvm/gems/ruby-1.9.2-p320@global/bin:/home/aepadmin/.rvm/rubies/ruby-1.9.2-p320/bin:/home/aepadmin/.rvm/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games"
default_environment["GEM_HOME"]     = "/home/aepadmin/.rvm/gems/ruby-1.9.2-p320"
default_environment["GEM_PATH"]     = "/home/aepadmin/.rvm/gems/ruby-1.9.2-p320:/home/aepadmin/.rvm/gems/ruby-1.9.2-p320@global"
default_environment["RUBY_VERSION"] = "1.9.2p320"

default_run_options[:shell] = 'bash'

namespace :deploy do
  desc "Deploy your application"
  task :default do
    update
    restart
  end

  desc "Setup your git-based deployment app"
  task :setup, :except => { :no_release => true } do
    dirs = [deploy_to, shared_path]
    dirs += shared_children.map { |d| File.join(shared_path, d) }
    run "#{try_sudo} mkdir -p #{dirs.join(' ')} && #{try_sudo} chmod g+w #{dirs.join(' ')}"
    run "git clone #{repository} #{current_path}"
  end

  task :cold do
    update
    migrate
  end

  task :update do
    transaction do
      update_code
    end
  end

  desc "Update the deployed code."
  task :update_code, :except => { :no_release => true } do
    run "cd #{current_path}; git fetch origin; git reset --hard #{branch}"
    finalize_update
  end

  desc "Update the database (overwritten to avoid symlink)"
  task :migrations do
    transaction do
      update_code
    end
    migrate
    restart
  end

  task :finalize_update, :except => { :no_release => true } do
    run "chmod -R g+w #{latest_release}" if fetch(:group_writable, true)

    run <<-CMD
      rm -rf #{latest_release}/log #{latest_release}/public/system #{latest_release}/tmp/pids &&
      mkdir -p #{latest_release}/public &&
      mkdir -p #{latest_release}/tmp &&
      ln -s #{shared_path}/log #{latest_release}/log &&
      ln -s #{shared_path}/system #{latest_release}/public/system &&
      ln -s #{shared_path}/pids #{latest_release}/tmp/pids &&
      ln -sf #{shared_path}/database.yml #{latest_release}/config/database.yml
    CMD

    if fetch(:normalize_asset_timestamps, true)
      stamp = Time.now.utc.strftime("%Y%m%d%H%M.%S")
      asset_paths = fetch(:public_children, %w(images stylesheets javascripts)).map { |p| "#{latest_release}/public/#{p}" }.join(" ")
      run "find #{asset_paths} -exec touch -t #{stamp} {} ';'; true", :env => { "TZ" => "UTC" }
    end
  end

  desc "Zero-downtime restart of Unicorn"
  task :restart, :except => { :no_release => true } do
    run "kill -s USR2 `cat /tmp/unicorn.aepokc.pid`"
  end

  desc "Start unicorn"
  task :start, :except => { :no_release => true } do
    run "cd #{current_path} ; bundle exec unicorn_rails -c config/unicorn.rb -D"
  end

  desc "Stop unicorn"
  task :stop, :except => { :no_release => true } do
    run "kill -s QUIT `cat /tmp/unicorn.aepokc.pid`"
    run "rm -r #{latest_release}/tmp/pids"
  end  

  namespace :rollback do
    desc "Moves the repo back to the previous version of HEAD"
    task :repo, :except => { :no_release => true } do
      set :branch, "HEAD@{1}"
      deploy.default
    end

    desc "Rewrite reflog so HEAD@{1} will continue to point to at the next previous release."
    task :cleanup, :except => { :no_release => true } do
      run "cd #{current_path}; git reflog delete --rewrite HEAD@{1}; git reflog delete --rewrite HEAD@{1}"
    end

    desc "Rolls back to the previously deployed version."
    task :default do
      rollback.repo
      rollback.cleanup
    end
  end
end

_cset(:whenever_roles)        { :db }
_cset(:whenever_options)      { {:roles => fetch(:whenever_roles)} }
_cset(:whenever_command)      { "whenever" }
_cset(:whenever_identifier)   { fetch :application }
_cset(:whenever_environment)  { fetch :rails_env, "production" }
_cset(:whenever_variables)    { "environment=#{fetch :whenever_environment}" }
_cset(:whenever_update_flags) { "--update-crontab #{fetch :whenever_identifier} --set #{fetch :whenever_variables}" }
_cset(:whenever_clear_flags)  { "--clear-crontab #{fetch :whenever_identifier}" }

# Disable cron jobs at the begining of a deploy.
after "deploy:update_code", "whenever:clear_crontab"
# Write the new cron jobs near the end.
before "deploy:restart", "whenever:update_crontab"
# If anything goes wrong, undo.
after "deploy:rollback", "whenever:update_crontab"

namespace :whenever do
  desc <<-DESC
    Update application's crontab entries using Whenever. You can configure \
    the command used to invoke Whenever by setting the :whenever_command \
    variable, which can be used with Bundler to set the command to \
    "bundle exec whenever". You can configure the identifier used by setting \
    the :whenever_identifier variable, which defaults to the same value configured \
    for the :application variable. You can configure the environment by setting \
    the :whenever_environment variable, which defaults to the same value \
    configured for the :rails_env variable which itself defaults to "production". \
    Finally, you can completely override all arguments to the Whenever command \
    by setting the :whenever_update_flags variable. Additionally you can configure \
    which servers the crontab is updated on by setting the :whenever_roles variable.
  DESC
  task :update_crontab do
    options = fetch(:whenever_options)

    if find_servers(options).any?
      on_rollback do
        if fetch :previous_release
          run "cd #{fetch :previous_release} bundle exec #{fetch :whenever_command} #{fetch :whenever_update_flags}", options
        else
          run "cd #{fetch :release_path} bundle exec #{fetch :whenever_command} #{fetch :whenever_clear_flags}", options
        end
      end

      run "cd #{fetch :current_path} bundle exec #{fetch :whenever_command} #{fetch :whenever_update_flags}", options
    end
  end

  desc <<-DESC
    Clear application's crontab entries using Whenever. You can configure \
    the command used to invoke Whenever by setting the :whenever_command \
    variable, which can be used with Bundler to set the command to \
    "bundle exec whenever". You can configure the identifier used by setting \
    the :whenever_identifier variable, which defaults to the same value configured \
    for the :application variable. Finally, you can completely override all \
    arguments to the Whenever command by setting the :whenever_clear_flags variable. \
    Additionally you can configure which servers the crontab is cleared on by setting \
    the :whenever_roles variable.
  DESC
  task :clear_crontab do
    options = fetch(:whenever_options)
    run "cd #{fetch :latest_release} bundle exec #{fetch :whenever_command} #{fetch :whenever_clear_flags}", options if find_servers(options).any?
  end
end

def run_rake(cmd)
  run "cd #{current_path}; #{rake} #{cmd}"
end
