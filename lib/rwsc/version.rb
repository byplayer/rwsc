# -*- coding: utf-8 -*-

module Rwsc
  module VERSION
    MAJOR = 0
    MINOR = 0
    TINY  = 2

    STRING =
      File.open(
        File.join(
          File.dirname(__FILE__), '..', '..', 'VERSION'), 'r').gets.chomp
  end
end
