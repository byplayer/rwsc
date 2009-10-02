# -*- coding: utf-8 -*-

module Rwsc
  class Config
    def self.proxy_host=(proxy_host)
      @@proxy_host = proxy_host
    end

    def self.proxy_host
      @@proxy_host
    end

    def self.proxy_port=(proxy_port)
      @@proxy_port = proxy_port
    end

    def self.proxy_port
      @@proxy_port
    end

    @@proxy_host = nil
    @@proxy_port = nil
  end
end
