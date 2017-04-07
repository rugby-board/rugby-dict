# coding: utf-8

task default: %w[test]

require "rake/testtask"

Rake::TestTask.new do |t|
  t.libs << "lib" << "test"
  p t.test_files = FileList["test/test_*.rb"].exclude(/^test\/test_spec/)
  t.verbose = true
end
