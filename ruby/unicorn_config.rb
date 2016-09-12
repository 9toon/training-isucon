app_dir = '/home/isucon/private_isu/webapp/ruby'

worker_processes 1
preload_app true
listen "127.0.0.1:8080"
pid "#{app_dir}/unicorn.pid"
stderr_path "#{app_dir}/log/unicorn.err.log"
stdout_path "#{app_dir}/log/unicorn.out.log"
