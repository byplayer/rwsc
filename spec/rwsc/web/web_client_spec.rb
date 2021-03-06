# -*- coding: utf-8 -*-
require File.expand_path(File.join(File.dirname(__FILE__),
                                   '..','..', 'spec_helper'))
require 'rwsc'


describe Rwsc::Web::WebClient do
  SEARCH_OPTS = {
    :affiliateId=>"testAflId",
    :operation=>"ItemSearch",
    :keyword=>"sample",
    :version=>"2010-09-15",
    :developerId=>"testdeveloperId"
  }

  subject {
    wc = Rwsc::Web::WebClient.new(SEARCH_OPTS[:operation])

    http_res = Object.new
    mock(http_res).body{
      body = ''
      File.open(File.join(File.dirname(__FILE__), 'sample.xml')){ |f|
        body = f.read
      }
      body
    }
    mock(wc).get_api_result(SEARCH_OPTS){ http_res }
    wc.get_result(SEARCH_OPTS)
  }

  it { subject.items.size.should == 30 }
  it { subject.status.status.should == "Success" }
  it { subject.args.size.should == 6 }
  it { subject.args[0].key.should == "User-Agent" }
  it { subject.args[0].value.should == Rwsc::CONST::USER_AGENT }
  it { subject.args[0].result.should == "true" }
end
