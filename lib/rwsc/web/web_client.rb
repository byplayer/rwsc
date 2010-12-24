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
        return WebClient.new(opts[:operation]).get_result(opts)
      end

      def get_result(opts)
        parse_result(get_api_result(opts).body)
      end

      private
      # == try proxy connect
      # use proxy connect if set proxy configuration .
      def get_api_result(opts)
        uri = generate_uri(opts)

        Net::HTTP.Proxy(Config.proxy_host,
                        Config.proxy_port).start(uri.host, uri.port) do |http|
          res = http.get("#{uri.path}?#{uri.query}",
                         {'User-Agent' => Rwsc::CONST::USER_AGENT})
          return res
        end
      end

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
      def parse_result(xml_string)
        @doc = Nokogiri::XML(xml_string)
        @namespaces = {}
        @doc.traverse { |d| @namespaces.merge! d.namespaces }

        #@item_search = ItemSearch.new
        @result_item = eval("#{@operation}.new")
        parse_status()
        parse_args()
        parse_common_info()
        parse_items()

        @result_item
      end

      # == parse status
      # if status is not success, this function raise
      #
      def parse_status()
        status = Status.new
        status.status = first_item_content('/Response/header:Header/Status')
        status.status_msg =
          first_item_content('/Response/header:Header/StatusMsg')
        @result_item.status = status

        unless @result_item.status.status == Status::SUCCESS
          raise StatusError.new("API Error(#{@result_item.status.status}):" +
                          "#{@result_item.status.status_msg}")
        end
      end

      # == parse ARG items
      def parse_args()
        args = []
        @doc.xpath('/Response/header:Header/Args/Arg', @namespaces).each do |a|
          args << Arg.new(a['key'],
                          a['value'],
                          a.content)
        end

        @result_item.args = args
      end

      # == parse common info
      def parse_common_info()
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
            first_item_content(
              "/Response/Body/#{@operation[0,1].downcase + @operation[1,@operation.length]}:#{@operation}/#{xml_tag}"))
        end
      end

      # == parse items
      def parse_items()
        items = []

        @doc.xpath("/Response/Body/#{@operation[0,1].downcase + @operation[1,@operation.length]}:#{@operation}/Items/Item",
                  @namespaces).each do |i|
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
      def first_item(xpath)
        items = @doc.xpath(xpath, @namespaces)
        if items && !items.empty?
          return items.first
        end

        nil
      end

      # == get first item content
      # if item not exist, return nil
      def first_item_content(xpath)
        item = first_item(xpath)
        if item
          return item.content
        end

        nil
      end
    end
  end
end
