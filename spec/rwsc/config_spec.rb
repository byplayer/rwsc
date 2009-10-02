# -*- coding: utf-8 -*-

require File.expand_path(File.join(File.dirname(__FILE__),
                                   '..', 'spec_helper'))
require 'rwsc/config'

describe Rwsc::Config do
  subject { Rwsc::Config.proxy_host }

  it { should be_nil }

  it "set proxy host" do
    proxy_host_name = "test.proxy.com"
    Rwsc::Config.proxy_host = proxy_host_name
    Rwsc::Config.proxy_host.should == proxy_host_name
  end

  subject { Rwsc::Config.proxy_port }

  it { should be_nil }

  it "should set proxy port" do
    proxy_port_val = 33
    Rwsc::Config.proxy_port = proxy_port_val
    should == proxy_port_val
  end
end

