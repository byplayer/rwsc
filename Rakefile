# -*- coding: utf-8 -*-
require 'rubygems'

gem 'rdoc'
require 'rdoc'

require 'rake'
require 'rake/rdoctask'

begin
  require 'spec/rake/spectask'
rescue LoadError
else
  # return rspec options
  def set_speck_opt(t)
    t.spec_files = FileList['spec/**/*_spec.rb']
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
end

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

  rdoc.options += [
    '-H' , '-a', '-t', '-d',
    '-f', 'darkfish',  # This is the important bit
  ]
end

# gem task
def gemspec
  @gemspec ||= begin
    file = File.expand_path('../rwsc.gemspec', __FILE__)
    eval(File.read(file), binding, file)
  end
end

begin
  require 'rake/gempackagetask'
rescue LoadError
  task(:gem) { $stderr.puts '`gem install rake` to package gems' }
else
  Rake::GemPackageTask.new(gemspec) do |pkg|
    pkg.gem_spec = gemspec
  end
  task :gem => :gemspec
end
