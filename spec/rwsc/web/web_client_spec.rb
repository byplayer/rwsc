# -*- coding: utf-8 -*-
require File.expand_path(File.join(File.dirname(__FILE__),
                                   '..','..', 'spec_helper'))
require 'rwsc'


describe Rwsc::Web::WebClient do
  SEARCH_OPTS = {
    :affiliateId=>"testAflId",
    :operation=>"ItemSearch",
    :keyword=>"sample",
    :version=>"2009-04-15",
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
end
