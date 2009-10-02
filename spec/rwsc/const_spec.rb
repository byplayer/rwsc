# -*- coding: utf-8 -*-
require File.expand_path(File.join(File.dirname(__FILE__),
                                   '..', 'spec_helper'))
require 'rwsc'

describe Rwsc::CONST do
  subject { Rwsc::CONST::USER_AGENT }

  it { should == "rwsc/#{Rwsc::VERSION::STRING}" }
end
