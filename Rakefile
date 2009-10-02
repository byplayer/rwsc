# -*- coding: utf-8 -*-

require 'rake'
require 'spec/rake/spectask'

def set_speck_opt(t)
  t.spec_files = FileList['spec/**/*_spec.rb']
  t.spec_opts = ['--color']
  t.warning = true
end

desc "Run all specs"
Spec::Rake::SpecTask.new('spec') do |t|
  set_speck_opt t
end

desc "Run rcov"
Spec::Rake::SpecTask.new('spec:rcov') do |t|
  set_speck_opt t
  t.rcov = true
end
