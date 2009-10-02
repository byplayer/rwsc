# -*- coding: utf-8 -*-
require 'rwsc/arg_error'

module Rwsc
  class ItemSearch
    def self.find(opts)
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
    end

    private
    def self.must_items
      MUST_ITEMS
    end

    MUST_ITEMS = [:developerId]

    def self.accept_items
      ACCEPT_ITEMS
    end
    ACCEPT_ITEMS = [
                    :developerId, :affiliateId,
                    :keyword,
                   ]
  end
end
