ROOT_DIR = File.expand_path(File.join(File.dirname(__FILE__), '..'))
ERR_FILE = File.join(ROOT_DIR, 'log', 'unicorn.err.log')
OUT_FILE = File.join(ROOT_DIR, 'log', 'unicorn.out.log')
PID_FILE = File.join(ROOT_DIR, 'tmp', 'pids', 'unicorn.pid')

listen '127.0.0.1:3000'
working_directory ROOT_DIR
worker_processes 4
stderr_path ERR_FILE
stdout_path OUT_FILE
pid PID_FILE
