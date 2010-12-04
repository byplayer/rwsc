# -*- coding: utf-8 -*-

module Rwsc
  # = this class is Rakuten Webservice result status item .
  class Status
    attr_accessor :status, :status_msg

    SUCCESS      = 'Success'
    NOT_FOUND    = 'NotFound'
    SERVER_ERROR = 'ServerError'
    CLIENT_ERROR = 'ClientError'
    MAINTENANCE  = 'Maintenance'

    def initialize(status = nil, status_msg = nil)
      self.status = status
      self.status_msg = status_msg
    end
  end
end
