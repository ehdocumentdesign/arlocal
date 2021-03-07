### for best results, use the true path for 'dir_app' rather than a method
dir_app = File.absolute_path('../')

dir_app_log = File.join(dir_app, 'log')
dir_app_shared = File.join(dir_app, 'shared')

working_directory dir_app

# Set unicorn options
worker_processes 2
preload_app true
timeout 30

# Set up socket location
listen "#{dir_app_shared}/unicorn.socket", :backlog => 64

# Set master PID location
pid "#{dir_app_shared}/unicorn.pid"

# Logging
stderr_path "#{dir_app_log}/unicorn.stderr.log"
stdout_path "#{dir_app_log}/unicorn.stdout.log"
