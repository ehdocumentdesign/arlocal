dir_app = File.absolute_path('../')
dir_app_log = File.join(app_dir, 'log')
dir_app_shared = File.join(app_dir, 'shared')

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
