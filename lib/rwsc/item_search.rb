# -*- coding: utf-8 -*-
require 'rwsc/web/web_client'

module Rwsc
  # = ItemSearch class
  # this class is ItemSearch API wrapper .
  class ItemSearch < ResultItem
    # == find item .
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

      self.rws_call(opts.merge(self.add_rwsc_opts))
    end

    private
    MUST_ITEMS = [:developerId]

    def self.must_items
      MUST_ITEMS
    end

    ACCEPT_ITEMS = [
                    :developerId,
                    :affiliateId,
                    :keyword,
                    :shopCode,
                    :genreId,
                    :catalogCode,
                    :hits,
                    :page,
                    :sort,
                    :minPrice,
                    :maxPrice,
                    :availability,
                    :field,
                    :carrier,
                    :imageFlag,
                    :orFlag,
                    :NGKeyword,
                    :genreInformationFlag,
                    :purchaseType,
                   ]

    def self.accept_items
      ACCEPT_ITEMS
    end

    # == Additional Rakuten web service call option
    ADD_RWSC_OPTS = {
      :version => CONST::API_VERSION,
      :operation => OPERATION::ITEM_SEARCH,
    }

    # == get additional Rakuten web service call option
    def self.add_rwsc_opts
      ADD_RWSC_OPTS
    end

    # == Rakuten web service call function
    def self.rws_call(opts)
      Rwsc::Web::WebClient.get_result(opts)
    end
  end
end
