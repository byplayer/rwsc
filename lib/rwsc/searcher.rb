# -*- coding: utf-8 -*-
require 'rwsc/web/web_client'
require 'rwsc/result_item'

module Rwsc
  module Searcher
    # == find item .
    def find(opts)
      if opts.nil?
        raise ArgError.new('no options')
      end

      self.must_items.each do |item|
        unless opts.include? item
          raise ArgError.new("#{item.to_s} needed")
        end
      end

      opts.each do |key, val|
        unless accept_items.include? key
          raise ArgError.new("#{key.to_s} is invalid option")
        end
      end

      self.rws_call(opts.merge(self.add_rwsc_opts))
    end

    # == Rakuten web service call function
    def rws_call(opts)
      Rwsc::Web::WebClient.get_result(opts)
    end
  end
end
