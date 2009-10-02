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
        call_http(opts)
      end

      private
      # = try proxy connect
      # use proxy connect if set proxy configuration .
      def self.call_http(opts)
        uri = generate_uri(opts)

        Net::HTTP.Proxy(Config.proxy_host,
                        Config.proxy_port).start(uri.host, uri.port) do |http|
          res = http.get("#{uri.path}?#{uri.query}",
                         {'User-Agent' => Rwsc::CONST::USER_AGENT})
          doc = Nokogiri::XML(res.body)
        end
      end

      # = generate uri object from opts .
      def self.generate_uri(opts)
        url = Rwsc::CONST::WS_URL + "?"
        if opts
          url += opts.map do |key, val|
            "#{URI.escape(key.to_s)}=#{URI.escape(val.to_s)}"
          end.join('&')
        end

        URI.parse(url)
      end
    end
  end
end
