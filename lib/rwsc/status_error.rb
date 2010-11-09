# -*- coding: utf-8 -*-

module Rwsc
  class StatusError < RuntimeError
    def initialize(msg)
      super(msg)
    end
  end
end
