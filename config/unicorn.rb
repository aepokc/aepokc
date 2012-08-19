env = ENV["RAILS_ENV"] || "development"

worker_processes 4

listen "/tmp/aepokc.socket", :backlog => 64

preload_app true

timeout 60

pid "/tmp/unicorn.aepokc.pid"

if env == "production"
  working_directory "/home/aepadmin/aepokc/current"

  user 'aepadmin'

  shared_path = "/home/aepadmin/aepokc/shared"

  stderr_path "#{shared_path}/log/unicorn.stderr.log"
  stdout_path "#{shared_path}/log/unicorn.stdout.log"
end

before_fork do |server, worker|
  if defined?(ActiveRecord::Base)
    ActiveRecord::Base.connection.disconnect!
  end

  old_pid = "/tmp/unicorn.aepokc.pid.oldbin"
  if File.exists?(old_pid) && server.pid != old_pid
    begin
      Process.kill("QUIT", File.read(old_pid).to_i)
    rescue Errno::ENOENT, Errno::ESRCH
      # someone else did out job for us
    end
  end
end

after_fork do |server, worker|
  if defined?(ActiveRecord::Base)
    ActiveRecord::Base.establish_connection
  end
end