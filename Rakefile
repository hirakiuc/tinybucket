require 'rubygems'
require 'bundler/setup'

require "bundler/gem_tasks"

desc 'launch an irb console with the gem loaded'
task :console do
  exec 'irb -I lib -r tinybucket'
end

desc 'cleanup rcov, doc directories'
task :clean do
  rm_rf 'coverage'
  rm_rf 'doc'
  rm_rf 'measurement'
end

# https://github.com/sferik/twitter/blob/master/Rakefile
require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec)
task :test => :spec

if Dir.exist?('./features')
  RSpec::Core::RakeTask.new(:features) do |t|
    t.pattern = './features/**/*_spec.rb'
    t.rspec_opts = '-I ./features'
  end
end

begin
  require 'rubocop/rake_task'
  RuboCop::RakeTask.new
rescue LoadError
  task :rubocop do
    $stderr.puts 'Rubocop is disabled.'
  end
end

require 'yard'
YARD::Rake::YardocTask.new

require 'yardstick/rake/measurement'
Yardstick::Rake::Measurement.new do |measurement|
  measurement.output = 'measurement/report.txt'
end

require 'yardstick/rake/verify'
Yardstick::Rake::Verify.new do |verify|
  verify.threshold = 59.6
end

task :default => [:spec, :rubocop]
