# -*- coding: utf-8 -*-

require File.expand_path(File.join(File.dirname(__FILE__),
                                   '..', 'spec_helper'))
require File.expand_path(File.join(File.dirname(__FILE__),
                                   '..', '..', 'lib', 'rwsc', 'version'))

describe Rwsc::VERSION do
  subject { Rwsc::VERSION::STRING }

  it { should == "#{Rwsc::VERSION::MAJOR}." +
                   "#{Rwsc::VERSION::MINOR}." +
                   "#{Rwsc::VERSION::TINY}" }
end
