require 'rcov/rcovtask'

def rcov_task(name, pattern, opts = [])
  Rcov::RcovTask.new(name.to_sym) do |t|
    t.libs       = %w/lib test/
    t.output_dir = "rcov/#{name}"
    t.rcov_opts  = %w/--rails --exclude '\/\.rvm\/'/ + opts
    t.test_files = FileList[pattern]
    t.verbose    = false
  end
end

namespace :rcov do
  rcov_task(:full, 'test/**/*_test.rb')

  rcov_task(:integration, 'test/integration/**/*_test.rb')

  rcov_task(:unit, 'test/unit/**/*_test.rb',
    %w[--exclude '\.' --include-file '^app\/models\/'])

  rcov_task(:functional, 'test/functional/**/*_test.rb',
    %w[--exclude '\.' --include-file '^app\/(controllers|mailers)\/'])
end
