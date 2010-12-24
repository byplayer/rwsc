# -*- coding: utf-8 -*-

module Rwsc

  # = this class is ResultItem base class .
  class ResultItem
    def method_missing(name, *args)
      @data_hash ||= {}

      method_name = name.to_s

      if method_name  =~ /(.*)=$/
        if args.size == 1
          @data_hash[$1] = args.shift
        else
          @data_hash[$1] = args
        end
      elsif args.nil? || args.empty?
        return  @data_hash[method_name]
      end

      nil
    end
  end
end
