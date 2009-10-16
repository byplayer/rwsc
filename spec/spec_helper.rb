# -*- coding: utf-8 -*-
require 'rubygems'
require 'spec'

$:.unshift File.expand_path(File.join(File.dirname(__FILE__), '..', 'lib'))
Dir[File.dirname(__FILE__) + "/matchers/**/*.rb"].each {|f| require f}
