# -*- coding: utf-8 -*-
require 'net/http'
require 'uri'
require 'rubygems'
require 'nokogiri'

module Rwsc
  module Web

    # = this class is Rakuten WebSearch web client .
    class WebClient
      def initialize operation
        @operation = operation
      end

      # == this method call webservice api .
      def self.get_result(opts)
        WebClient.new(opts[:operation]).call_http(opts)
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
        #@item_search = ItemSearch.new
        @result_item = eval("#{@operation}.new")
        parse_status(doc)
        parse_args(doc)
        parse_common_info(doc)
        parse_items(doc)

        @result_item
      end

      # == parse status
      # if status is not success, this function raise
      #
      def parse_status(doc)
        status = Status.new
        status.status = first_item_content(doc, '/Response/header:Header/Status')
        status.status_msg =
          first_item_content(doc, '/Response/header:Header/StatusMsg')
        @result_item.status = status

        unless @result_item.status.status == Status::SUCCESS
          raise StatusError.new("API Error(#{@result_item.status.status}):" +
                          "#{@result_item.status.status_msg}")
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

        @result_item.args = args
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
          @result_item.send("#{func}=",
            first_item_content(doc,
              "/Response/Body/#{@operation[0,1].downcase + @operation[1,@operation.length]}:#{@operation}/#{xml_tag}"))
        end
      end

      # == parse items
      def parse_items(doc)
        items = []

        doc.xpath("/Response/Body/#{@operation[0,1].downcase + @operation[1,@operation.length]}:#{@operation}/Items/Item",
                  doc.namespaces).each do |i|
          item = ResultItem.new

          i.children.each do |element|

            item.send("#{Rwsc::Utils::StringUtils.underscore(element.name)}=",
                      element.content)
          end

          items << item
        end

        @result_item.items = items
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
