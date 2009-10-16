# -*- coding: utf-8 -*-
require File.expand_path(File.join(File.dirname(__FILE__),
                                   '..', '..', 'spec_helper'))
require 'rwsc'

describe "StringUtils" do
  it { "page".should be_underscore_of("page") }
  it { "pageCount".should be_underscore_of("page_count") }
  it { "genreId".should be_underscore_of("genre_id") }
  it { "Status".should be_underscore_of("status") }
  it { "StatusMsg".should be_underscore_of("status_msg") }
  it { "smallImageUrl".should be_underscore_of("small_image_url") }
end
