# -*- coding: utf-8 -*-

module Rwsc
  class ArgError < RuntimeError
    def initialize(msg)
      super(msg)
    end
  end
end
