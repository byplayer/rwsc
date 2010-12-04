# -*- coding: utf-8 -*-

module Rwsc
  module Utils
    module StringUtils
      # The reverse of +camelize+. Makes an underscored, lowercase .
      def self.underscore word
        return word unless word =~ /[A-Z]/
        word.gsub(/([a-z\d]+)([A-Z]+)/, '\1_\2').downcase
      end
    end
  end
end
