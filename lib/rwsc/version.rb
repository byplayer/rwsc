# -*- coding: utf-8 -*-

module Rwsc
  module VERSION
    STRING =
      File.open(
        File.join(
                  File.dirname(__FILE__), '..', '..', 'VERSION'), 'r'){ |f| f.gets.chomp }

    MAJOR = $1.to_i if STRING =~ /^([0-9]+)\.([0-9]+)\.([0-9]+)/
    MINOR = $2.to_i if STRING =~ /^([0-9]+)\.([0-9]+)\.([0-9]+)/
    TINY  = $3.to_i if STRING =~ /^([0-9]+)\.([0-9]+)\.([0-9]+)/
  end
end
