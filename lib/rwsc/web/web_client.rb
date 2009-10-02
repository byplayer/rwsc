# -*- coding: utf-8 -*-
require 'net/http'
require 'uri'
require 'rubygems'
require 'nokogiri'

module Rwsc
  module Web

    # = this class is Rakuten WebSearch web client .
    class WebClient
      # = this method call webservice api .
      def self.get_result(opts)
        WebClient.new.call_http(opts)
      end

      # = try proxy connect
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
      # = generate uri object from opts .
      def generate_uri(opts)
        url = Rwsc::CONST::WS_URL + "?"
        if opts
          url += opts.map do |key, val|
            "#{URI.escape(key.to_s)}=#{URI.escape(val.to_s)}"
          end.join('&')
        end

        URI.parse(url)
      end

      # = parse xml items
      def parse_result(doc)
        @item_search = ItemSearch.new
        parse_status(doc)
        parse_args(doc)

        @item_search
      end

      # = parse status
      # if status is not success, this function raise
      #
      def parse_status(doc)
        status = Status.new
        doc.xpath('/Response/header:Header/Status', doc.namespaces).each do |s|
          status.status = s.content
        end

        doc.xpath('/Response/header:Header/StatusMsg', doc.namespaces).each do |m|
          status.status_msg = m.content
        end
        @item_search.status = status

        unless @item_search.status.status == Status::SUCCESS
          raise StatusError.new("API Error(#{@item_search.status.status}):" +
                          "#{@item_search.status.status_msg}")
        end
      end

      # = parse ARG items
      def parse_args(doc)
        args = []
        doc.xpath('/Response/header:Header/Args/Arg', doc.namespaces).each do |a|
          args << Arg.new(a.attribute('key'),
                          a.attribute('value'),
                          a.content)
        end

        @item_search.args = args
      end
    end
  end
end
