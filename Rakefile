require 'rake'
require 'rake/testtask'

Rake::TestTask.new do |t|
	t.pattern = '*_test.rb'
	t.ruby_opts = ["-rminitest/pride"]
end
task default: :test
