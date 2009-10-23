# -*- coding: utf-8 -*-
require 'rubygems'
require 'rake'
require 'spec/rake/spectask'
require 'rake/gempackagetask'
require "rtask"


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

# gem tasks
PKG_FILES = FileList[
  '[A-Z]*',
  'bin/**/*',
  'lib/**/*.rb',
  'test/**/*.rb',
  'doc/**/*',
  'spec/**/*.rb',
]

VER_NUM = `ruby -Ilib -e 'require "rwsc/version"; puts Rwsc::VERSION::STRING'`

if VER_NUM =~ /([0-9.]+)$/
  CURRENT_VERSION = $1
else
  CURRENT_VERSION = "0.0.0"
end

class RTask
  # overwrite init_spec
  # get version automaticaly .
  # get package files automaticaly .
  def init_spec
    ::Gem::Specification.new do |s|
      s.name = "rwsc"
      s.version = CURRENT_VERSION
      s.summary = "Rakuten Webservice client library"
      s.description = <<-EOS
Rakuten Webservice client library
      EOS
      s.authors = ["byplayer", "takayoshi kohayakawa"]
      s.email = ["byplayer100@gmail.com",
                 "takayoshi.kohayakawa@mail.rakuten.co.jp"]
      s.homepage = "http://wiki.github.com/byplayer/rwsc"

      s.files = PKG_FILES.to_a

      s.require_path = 'lib'

      s.has_rdoc = true
      s.rdoc_options << '--line-numbers' << '--inline-source' <<
        "--main" << "README.rdoc" << "-c UTF-8"
      s.extra_rdoc_files = ["README.rdoc"]

      s.add_dependency('nokogiri')
      s.add_dependency('rspec')
    end
  end

  # overwrite
  # get package files automaticaly
  def manifest
    PKG_FILES.to_a
  end

  def tgz
    base_name = "#{@package}-#{@version}"
    tgz_name = "#{base_name}.tgz"

    to_base = File.expand_path(File.join(File.dirname(__FILE__),"#{base_name}"))
    FileUtils.mkdir_p(to_base)

    manifest.each do |fname|
      to_fname = File.join(to_base, fname)
      FileUtils.mkdir_p(File.dirname(to_fname))
      FileUtils.copy_entry(fname, to_fname)
    end

    sh "tar -c -z -f #{tgz_name} #{base_name}"

    FileUtils.remove_entry(to_base)
  end
end

# create rtask tasks
RTask.new
