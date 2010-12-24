# -*- coding: utf-8 -*-

require 'rwsc'
require 'optparse'

options = {}
opt = OptionParser.new
opt.on('-d DEVID', '--developerid DEVID'){|id| options[:developerId] = id}
opt.on('-a AFFID', '--affiliateid DEVID'){|id| options[:affiliateId] = id}
opt.on('-k KEYWORD', '--keyword KEYWORD'){|keyword| options[:keyword] = keyword}
opt.parse!(ARGV)

result = Rwsc::ItemSearch.find(options)
result.items.each do |item|
  puts item.item_name
end

