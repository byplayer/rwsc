# -*- coding: utf-8 -*-
require 'rwsc/searcher'
require 'rwsc/result_item'

module Rwsc
  # = ItemSearch class
  # this class is ItemSearch API wrapper .
  class ItemSearch < ResultItem
    extend Searcher

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
  end
end
