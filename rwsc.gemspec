# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib/', __FILE__)
$:.unshift lib unless $:.include?(lib)
require 'rwsc/version'

Gem::Specification.new do |s|
  s.name = %q{rwsc}
  s.version = Rwsc::VERSION::STRING
  s.authors = ["byplayer", "takayoshi kohayakawa"]
  s.date = %q{2009-12-28}
  s.description = <<EOS
Rakuten Webservice client library
EOS
  s.email = ["byplayer100@gmail.com", "takayoshi.kohayakawa@mail.rakuten.co.jp"]
  s.extra_rdoc_files = [
    "README.rdoc"
  ]
  s.files = FileList[
    '[A-Z]*',
    'bin/**/*',
    'lib/**/*.rb',
    'test/**/*.rb',
    'doc/**/*',
    'spec/**/*.rb',
  ]
  s.homepage = "http://wiki.github.com/byplayer/rwsc"
  s.rdoc_options = ["--charset=UTF-8", "--line-numbers", "--inline-source",
                    "--main", "README.rdoc", "-c UTF-8"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{rwsc}
  s.rubygems_version = %q{1.3.5}
  s.summary = %q{Rakuten Webservice client library}
  s.test_files = Dir.glob("spec/**/*")

  s.add_dependency("nokogiri", [">= 1.4.0"])
  s.add_dependency("rspec", [">= 1.3.0"])
end

