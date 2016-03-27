# Рабочие директории приложения на сервере
root        = '/home/rinykia/application'
rails_root  = "#{root}/current"

# Файлы, хранящие идентификаторы запущенных Unicorn-процессов
pidfile     = "#{root}/shared/run/unicorn.pid"
pidfile_old = pidfile + '.oldbin'
pid pidfile

# Главные параметры
worker_processes 1
preload_app true
timeout 30

# Путь к сокету
listen "#{root}/shared/run/unicorn.sock", :backlog => 1024

# Путь к лог-файлам
stderr_path "#{rails_root}/log/unicorn_error.log"
stdout_path "#{rails_root}/log/unicorn.log"

# Установки сборщика мусора
GC.copy_on_write_friendly = true if GC.respond_to?(:copy_on_write_friendly=)

# Блок инструкций, выполняемых до запуска сервера
before_exec do |server|
  ENV["BUNDLE_GEMFILE"] = "#{rails_root}/Gemfile"
end

# Инструкции для управления воркерами и состоянием соединения с БД

before_fork do |server, worker|
  defined?(ActiveRecord::Base) and
    ActiveRecord::Base.connection.disconnect!
  if File.exists?(pidfile_old) && server.pid != pidfile_old
    begin
      Process.kill("QUIT", File.read(pidfile_old).to_i)
    rescue Errno::ENOENT, Errno::ESRCH
    end
  end
end

after_fork do |server, worker|
  defined?(ActiveRecord::Base) and
    ActiveRecord::Base.establish_connection
end

namespace :nginx do
  desc 'Создание симлинка в /etc/nginx/conf.d на nginx.conf приложения'
  task :append_config do
    on roles :all do
      sudo :ln, "-fs #{shared_path}/config/nginx.conf /etc/nginx/conf.d/#{fetch(:application)}.conf"
    end
  end
  desc 'Релоад nginx'
  task :reload do
    on roles :all do
      sudo :service, :nginx, :reload
    end
  end
  desc 'Рестарт nginx'
  task :restart do
    on roles :all do
      sudo :service, :nginx, :restart
    end
  end
  after :append_config, :restart
end

set :unicorn_config, "#{shared_path}/config/unicorn.rb"
set :unicorn_pid, "#{shared_path}/run/unicorn.pid"

namespace :application do
  desc 'Запуск Unicorn'
  task :start do
    on roles(:app) do
      execute "cd #{release_path} && ~/.rvm/bin/rvm default do bundle exec unicorn_rails -c #{fetch(:unicorn_config)} -E #{fetch(:rails_env)} -D"
    end
  end
  desc 'Завершение Unicorn'
  task :stop do
    on roles(:app) do
      execute "if [ -f #{fetch(:unicorn_pid)} ] && [ -e /proc/$(cat #{fetch(:unicorn_pid)}) ]; then kill -9 `cat #{fetch(:unicorn_pid)}`; fi"
    end
  end
end

namespace :deploy do
  after :finishing, 'application:stop'
  after :finishing, 'application:start'
  after :finishing, :cleanup
end