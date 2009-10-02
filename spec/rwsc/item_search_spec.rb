# -*- coding: utf-8 -*-
require File.expand_path(File.join(File.dirname(__FILE__),
                                   '..', 'spec_helper'))
require 'rwsc'

describe Rwsc::ItemSearch do
  it "should raise ArgError with no options msg" do
    expect {
      Rwsc::ItemSearch.find(nil)
    }.should raise_error{ |e|
      e.should be_instance_of Rwsc::ArgError
      e.to_s.should == "no options"
    }
  end

  it "should set developerId" do
    expect {
      Rwsc::ItemSearch.find({})
    }.should raise_error { |e|
      e.should be_instance_of Rwsc::ArgError
      e.to_s.should == "developerId needed"
    }
  end

  it "should raise ArgError on invalid options" do
    expect {
      Rwsc::ItemSearch.find({
                              :developerId => 'test_id',
                              :hogehoge => 'aa'
                            })
    }.should raise_error { |e|
      e.should be_instance_of Rwsc::ArgError
      e.to_s.should == "hogehoge is invalid option"
    }
  end
end
