# -*- coding: utf-8 -*-

require File.expand_path(File.join(File.dirname(__FILE__),
                                   '..', 'spec_helper'))
require 'rwsc/version'

describe "Rwsc::VERSION::STRING" do
  subject { Rwsc::VERSION::STRING }

  it { should == "#{Rwsc::VERSION::MAJOR}." +
                   "#{Rwsc::VERSION::MINOR}." +
                   "#{Rwsc::VERSION::TINY}" }

  it { should == File.open(
                   File.join(
                     File.dirname(__FILE__), '..', '..',
                             'VERSION'), 'r'){ |f| f.gets.chomp } }
end

describe "Rwsc::VERSION numbers" do
  before(:each) do
    @file_version =
      File.open(
                File.join(
                          File.dirname(__FILE__), '..', '..',
                          'VERSION'), 'r'){ |f| f.gets.chomp }
    if @file_version =~ /^([0-9]+)\.([0-9]+)\.([0-9]+)/
      @file_major = $1.to_i
      @file_minor = $2.to_i
      @file_tiny = $3.to_i
    end
  end

  it { Rwsc::VERSION::MAJOR.should == @file_major }
  it { Rwsc::VERSION::MINOR.should == @file_minor }
  it { Rwsc::VERSION::TINY.should == @file_tiny }
end
