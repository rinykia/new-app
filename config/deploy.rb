# config valid only for Capistrano 3.1
lock '3.4.0'
# Название приложения
set :application, 'new-app'
# Путь к git репозиторию
set :repo_url, 'git@github.com:rinykia/new-app.git'
# Ветка по-умолчанию
set :branch, 'master'
# Директория для деплоя
set :deploy_to, '/home/rinykia/applications/new-app'

set :log_level, :info
# Копирующиеся файлы и директории (между деплоями)
set :linked_files, %w{config/database.yml config/settings.yml}
set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/uploads}

# Ruby свистелки
set :rbenv_type, :user
set :rbenv_ruby, '2.3.1'
set :rbenv_prefix, "RBENV_ROOT=#{fetch(:rbenv_path)} RBENV_VERSION=#{fetch(:rbenv_ruby)} #{fetch(:rbenv_path)}/bin/rbenv exec"
set :rbenv_roles, :all

# А это рекомендуют добавить для приложений, использующих ActiveRecord
set :puma_init_active_record, true

#set :ssh_options,{ forward_agent: true, user: fetch(:user), keys: %w(~/.ssh/id_rsa.pub) }
# А это рекомендуют добавить для приложений, использующих ActiveRecord

# Default branch is :master
# ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }.call

# Default deploy_to directory is /var/www/my_app
# set :deploy_to, '/var/www/my_app'

# Default value for :scm is :git
# set :scm, :git

# Default value for :format is :pretty
# set :format, :pretty

# Default value for :log_level is :debug
# set :log_level, :debug

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# set :linked_files, %w{config/database.yml}

# Default value for linked_dirs is []
# set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
# set :keep_releases, 5
desc 'Run rake tasks on server'
task :rake do
  on roles(:app), in: :sequence, wait: 5 do
    within release_path do
      with rails_env: :production do
        execute :rake, ENV['task'], 'RAILS_ENV=production'
      end
    end
  end
end
namespace :deploy do

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      # Your restart mechanism here, for example:
      # execute :touch, release_path.join('tmp/restart.txt')
    end
  end

  after :publishing, :restart

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end

end
