app_path = File.expand_path('../../../', __FILE__)


# 参考サイト(クラシルのバックエンド)
# https://tech.dely.jp/entry/2017/06/21/191832
worker_processes 6

working_directory '/usr/share/nginx/html/stapic/rails/current'

unicorn_backlog = ENV["UNICORN_BACKLOG"] || 4096

pid "#{app_path}/tmp/pids/unicorn.pid"
listen "#{app_path}/tmp/sockets/unicorn.sock", :backlog =>  Integer(unicorn_backlog)
stderr_path "#{app_path}/log/unicorn.stderr.log"
stdout_path "#{app_path}/log/unicorn.stdout.log"

timeout 180

preload_app true
GC.respond_to?(:copy_on_write_friendly=) && GC.copy_on_write_friendly = true

check_client_connection false

run_once = true

before_fork do |server, worker|
  defined?(ActiveRecord::Base) &&
      ActiveRecord::Base.connection.disconnect!

  if run_once
    run_once = false # prevent from firing again
  end

  old_pid = "#{server.config[:pid]}.oldbin"
  if File.exist?(old_pid) && server.pid != old_pid
    begin
      sig = (worker.nr + 1) >= server.worker_processes ? :QUIT : :TTOU
      Process.kill(sig, File.read(old_pid).to_i)
    rescue Errno::ENOENT, Errno::ESRCH => e
      Rails.logger.error(e)
    end
  end
end

after_fork do |_server, _worker|
  defined?(ActiveRecord::Base) && ActiveRecord::Base.establish_connection
end
