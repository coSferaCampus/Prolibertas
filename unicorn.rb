# Environment
environment = ENV['RACK_ENV'] || ENV['RAILS_ENV'] || 'production'

# Use at least one worker per core if you're on a dedicated server,
# more will usually help for _short_ waits on databases/caches.
worker_processes ENV['UNICORN_WORKERS'].to_i

# Since Unicorn is never exposed to outside clients, it does not need to
# run on the standard HTTP port (80), there is no reason to start Unicorn
# as root unless it's from system init scripts.
# If running the master process as root and the workers as an unprivileged
# user, do this to switch euid/egid in the workers (also chowns logs):
# user "unprivileged_user", "unprivileged_group"

if environment == 'production'
  # Help ensure your application will always spawn in the symlinked
  # "current" directory that Capistrano sets up.
  working_directory "/prolibertas" # available in 0.94.0+

  # listen on both a Unix domain socket and a TCP port,
  # we use a shorter backlog for quicker failover when busy
  listen '0.0.0.0:9000', :tcp_nopush => true

  # feel free to point this anywhere accessible on the filesystem
  pid "/prolibertas/tmp/pids/unicorn.pid"

  # By default, the Unicorn logger will write to stderr.
  # Additionally, some applications/frameworks log to stderr or stdout,
  # so prevent them from going to /dev/null when daemonized here:
  stderr_path "/prolibertas/log/unicorn.stderr.log"
  stdout_path "/prolibertas/log/unicorn.stdout.log"
end

# nuke workers after 30 seconds instead of 60 seconds (the default)
timeout 60
