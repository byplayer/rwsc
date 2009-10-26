# -*- coding: utf-8 -*-
require 'rubygems'
require 'rake'
require 'spec/rake/spectask'
require 'jeweler'

# return rspec options
def set_speck_opt(t)
  t.spec_files = FileList['spec/**/*_spec.rb']
  t.spec_opts = ['--color']
  t.warning = true
end

# rspec tasks
desc "Run all specs"
Spec::Rake::SpecTask.new('spec') do |t|
  set_speck_opt t
end

# rspec coverate tasks
desc "Run rcov"
Spec::Rake::SpecTask.new('spec:rcov') do |t|
  set_speck_opt t
  t.rcov = true
end


require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  begin
    version = File.read('VERSION').chomp
  rescue
    version = "0.0.0"
    puts "No version is set in file VERSION.  Set by default to #{version}"
  end

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "rwsc #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

# gem tasks
PKG_FILES = FileList[
  '[A-Z]*',
  'bin/**/*',
  'lib/**/*.rb',
  'test/**/*.rb',
  'doc/**/*',
  'spec/**/*.rb',
]

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gemspec|
    gemspec.name = "rwsc"
    gemspec.rubyforge_project = gemspec.name
    gemspec.summary = "Rakuten Webservice client library"
    gemspec.description = "<<-EOS
Rakuten Webservice client library
    EOS"
    gemspec.email = ["byplayer100@gmail.com",
               "takayoshi.kohayakawa@mail.rakuten.co.jp"]
    gemspec.homepage = "http://wiki.github.com/byplayer/rwsc"
    gemspec.authors = ["byplayer", "takayoshi kohayakawa"]

    gemspec.files = PKG_FILES.to_a

    gemspec.require_path = 'lib'
    gemspec.rdoc_options << '--line-numbers' << '--inline-source' <<
            "--main" << "README.rdoc" << "-c UTF-8"
    
    gemspec.extra_rdoc_files = ["README.rdoc"]

    gemspec.add_dependency('nokogiri')
    gemspec.add_dependency('rspec')

  end
rescue LoadError
  puts "Jeweler not available. Install it with: sudo gem install technicalpickles-jeweler -s http://gems.github.com"
end

