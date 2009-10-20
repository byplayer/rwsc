# -*- coding: utf-8 -*-
require 'net/http'
require 'uri'
require 'rubygems'
require 'nokogiri'

module Rwsc
  module Web

    # = this class is Rakuten WebSearch web client .
    class WebClient
      # == this method call webservice api .
      def self.get_result(opts)
        WebClient.new.call_http(opts)
      end

      # == try proxy connect
      # use proxy connect if set proxy configuration .
      def call_http(opts)
        uri = generate_uri(opts)

        Net::HTTP.Proxy(Config.proxy_host,
                        Config.proxy_port).start(uri.host, uri.port) do |http|
          res = http.get("#{uri.path}?#{uri.query}",
                         {'User-Agent' => Rwsc::CONST::USER_AGENT})
          parse_result(Nokogiri::XML(res.body))
        end
      end

      private
      # == generate uri object from opts .
      def generate_uri(opts)
        url = Rwsc::CONST::WS_URL + "?"
        if opts
          url += opts.map do |key, val|
            "#{URI.escape(key.to_s)}=#{URI.escape(val.to_s)}"
          end.join('&')
        end

        URI.parse(url)
      end

      # == parse xml items
      def parse_result(doc)
        @item_search = ItemSearch.new
        parse_status(doc)
        parse_args(doc)
        parse_common_info(doc)
        parse_items(doc)

        @item_search
      end

      # == parse status
      # if status is not success, this function raise
      #
      def parse_status(doc)
        status = Status.new
        status.status = first_item_content(doc, '/Response/header:Header/Status')
        status.status_msg =
          first_item_content(doc, '/Response/header:Header/StatusMsg')
        @item_search.status = status

        unless @item_search.status.status == Status::SUCCESS
          raise StatusError.new("API Error(#{@item_search.status.status}):" +
                          "#{@item_search.status.status_msg}")
        end
      end

      # == parse ARG items
      def parse_args(doc)
        args = []
        doc.xpath('/Response/header:Header/Args/Arg', doc.namespaces).each do |a|
          args << Arg.new(a.attribute('key'),
                          a.attribute('value'),
                          a.content)
        end

        @item_search.args = args
      end

      # == parse common info
      def parse_common_info(doc)
        {
          'count' => 'count',
          'page' => 'page',
          'first' => 'first',
          'last' => 'last',
          'hits'=> 'hits',
          'carrier' => 'carrier',
          'pageCount' => 'page_count',
        }.each do |xml_tag, func|
          @item_search.send("#{func}=",
            first_item_content(doc,
              "/Response/Body/itemSearch:ItemSearch/#{xml_tag}"))
        end
      end

      # == parse items
      def parse_items(doc)
        items = []

        doc.xpath('/Response/Body/itemSearch:ItemSearch/Items/Item',
                  doc.namespaces).each do |i|
          item = ResultItem.new

          i.children.each do |element|

            item.send("#{Rwsc::Utils::StringUtils.underscore(element.name)}=",
                      element.content)
          end

          items << item
        end

        @item_search.items = items
      end

      # == get first item
      # if item not exists, return nil
      def first_item(doc, xpath)
        items = doc.xpath(xpath, doc.namespaces)
        if items && !items.empty?
          return items.first
        end

        nil
      end

      # == get first item content
      # if item not exist, return nil
      def first_item_content(doc, xpath)
        item = first_item(doc, xpath)
        if item
          return item.content
        end

        nil
      end
    end
  end
end
