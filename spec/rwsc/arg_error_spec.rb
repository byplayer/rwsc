# -*- coding: utf-8 -*-
require File.expand_path(File.join(File.dirname(__FILE__),
                                   '..', 'spec_helper'))
require 'rwsc/arg_error'


describe Rwsc::ArgError, "message method" do
  subject { Rwsc::ArgError.new("my error msg").message }

  it { should == "my error msg" }
end

describe Rwsc::ArgError, "to_s method" do
  subject { Rwsc::ArgError.new("my error msg by to_s").to_s }
  it { should == "my error msg by to_s" }
end
