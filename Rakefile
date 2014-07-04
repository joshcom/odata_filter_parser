#!/usr/bin/env rake
require "bundler/gem_tasks"
require 'rake/testtask'

Rake::TestTask.new do |t|
  t.libs << 'spec'
  t.pattern = "spec/**/*_spec.rb"
end
Rake::Task[:spec].prerequisites.unshift "parser:build"
task :spec => :test

task :console do
  require 'irb'
  require 'irb/completion'
  require 'odata_filter_parser'

  ARGV.clear
  IRB.start
end

namespace :parser do
  task :build do
    sh "racc -l -o lib/odata_filter_parser/parser.rb lib/odata_filter_parser/parser.y"
  end
end
