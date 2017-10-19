require 'bundler/gem_tasks'
require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:spec)

task default: :spec

task :rubocop do
  puts '[Rubocop] checking  ...'
  cmd = 'rubocop'
  if system(cmd)
    puts '[Rubocop] all ok!'
  else
    exit 1
  end
end

Rake::Task['spec'].enhance ['rubocop']
