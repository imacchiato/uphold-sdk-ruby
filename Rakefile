require 'bundler/gem_tasks'
require 'rubocop/rake_task'
require 'rspec/core/rake_task'
RuboCop::RakeTask.new
RSpec::Core::RakeTask.new(:spec)

task :console do
  require 'irb'
  require 'irb/completion'
  require 'bitreserve'
  ARGV.clear
  IRB.start
end

task default: [:rubocop, :spec]