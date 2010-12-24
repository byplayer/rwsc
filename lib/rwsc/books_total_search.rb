# -*- coding: utf-8 -*-
require 'rwsc/searcher'
require 'rwsc/result_item'

module Rwsc
  # = BooksTotalSearch class
  # this class is BooksTotalSearch API wrapper .
  class BooksTotalSearch < ResultItem
		include Rwsc::Utils::Pager
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
                    :booksGenreId,
                    :hits,
                    :page,
                    :availability,
                    :outOfStockFlag,
                    :sort,
                    :field,
                    :carrier,
                    :orFlag,
                    :NGKeyword,
                    :genreInformationFlag
                   ]

    def self.accept_items
      ACCEPT_ITEMS
    end

    API_VERSION = '2010-03-18'
    # == Additional Rakuten web service call option
    ADD_RWSC_OPTS = {
      :version => self::API_VERSION,
      :operation => OPERATION::BOOKS_TOTAL_SEARCH,
    }

    # == get additional Rakuten web service call option
    def self.add_rwsc_opts
      ADD_RWSC_OPTS
    end
  end
end
