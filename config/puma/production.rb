threads_count = 5
threads threads_count, threads_count

# Specifies the `port` that Puma will listen on to receive requests; default is 3000.
# port 3000
# bind "unix://#{Rails.root}/tmp/sockets/puma.sock"

# Specifies the `environment` that Puma will run in.
# environment 'production'

# Specifies the `pidfile` that Puma will use.
pidfile 'tmp/pids/server.pid'

# Specifies the number of `workers` to boot in clustered mode.
workers 2

# Use the `preload_app!` method when specifying a `workers` number.
# preload_app!

# Allow puma to be restarted by `rails restart` command.
plugin :tmp_restart
