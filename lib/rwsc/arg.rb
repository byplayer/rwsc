# -*- coding: utf-8 -*-

module Rwsc
  # = this class is Rakuten Webservice result arg item .
  class Arg
    attr_accessor :key, :value, :result

    def initialize(key, value, result)
      self.key = key
      self.value = value
      self.result = result
    end
  end
end
