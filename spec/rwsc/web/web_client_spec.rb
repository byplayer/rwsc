# -*- coding: utf-8 -*-
require File.expand_path(File.join(File.dirname(__FILE__),
                                   '..','..', 'spec_helper'))
require 'rwsc'


describe Rwsc::Web::WebClient do
  SEARCH_OPTS = {
    :affiliateId=>"testAflId",
    :operation=>"ItemSearch",
    :keyword=>"Lumix",
    :version=>"2009-04-15",
    :developerId=>"testdeveloperId"
  }

  before(:each) do
    # mock(Rwsc::Web::WebClient).call_http(SEARCH_OPTS) { '' }
  end

  it "should what exactly?" do
    result = Rwsc::Web::WebClient.get_result(SEARCH_OPTS)
    p result
  end
end
