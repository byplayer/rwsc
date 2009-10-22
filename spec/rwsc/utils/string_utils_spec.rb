# -*- coding: utf-8 -*-
require File.expand_path(File.join(File.dirname(__FILE__),
                                   '..', '..', 'spec_helper'))
require 'rwsc'

describe "StringUtils" do
  it { "itemName".should be_underscore_of("item_name")}
  it { "itemCode".should be_underscore_of("item_code")}
  it { "itemPrice".should be_underscore_of("item_price")}
  it { "itemCaption".should be_underscore_of("item_caption")}
  it { "itemUrl".should be_underscore_of("item_url")}
  it { "affiliateUrl".should be_underscore_of("affiliate_url")}
  it { "imageFlag".should be_underscore_of("image_flag")}
  it { "smallImageUrl".should be_underscore_of("small_image_url")}
  it { "mediumImageUrl".should be_underscore_of("medium_image_url")}
  it { "availability".should be_underscore_of("availability")}
  it { "taxFlag".should be_underscore_of("tax_flag")}
  it { "postageFlag".should be_underscore_of("postage_flag")}
  it { "creditCardFlag".should be_underscore_of("credit_card_flag")}
  it { "shopOfTheYearFlag".should be_underscore_of("shop_of_the_year_flag")}
  it { "affiliateRate".should be_underscore_of("affiliate_rate")}
  it { "startTime".should be_underscore_of("start_time")}
  it { "endTime".should be_underscore_of("end_time")}
  it { "reviewCount".should be_underscore_of("review_count")}
  it { "reviewAverage".should be_underscore_of("review_average")}
  it { "shopName".should be_underscore_of("shop_name")}
  it { "shopCode".should be_underscore_of("shop_code")}
  it { "shopUrl".should be_underscore_of("shop_url")}
  it { "genreId".should be_underscore_of("genre_id")}
end
