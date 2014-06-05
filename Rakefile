require 'rake/testtask'
require 'rubygems/package_task'

task :default => :test

Rake::TestTask.new do |t|
  # t.libs.delete 'lib'
  # t.libs = ['test', 'app']
  t.libs << 'test'
  t.pattern = 'test/**/*_test.rb'
  t.warning = false
end

#to run isolated tests...
namespace :test do
  task :isolated do
    Dir.glob("test/**/*_test.rb").all? do |file|
      sh(Gem.ruby, '-w', '-Ilib:test', file)
    end or raise "Failures"
  end
end
