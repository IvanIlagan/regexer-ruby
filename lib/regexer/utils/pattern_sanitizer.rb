# frozen_string_literal: true

require "regexer/models/pattern"

module Regexer
  module Utils
    # A Utility Class that sanitizes a given value (mostly values given from the pattern builder)
    # that is valid for regex
    class PatternSanitizer
      def self.sanitize(value)
        if value.instance_of?(Regexer::Models::Pattern)
          sanitize(value.raw_pattern) unless value.regex_escaped?
          value.raw_pattern
        else
          Regexp.escape(value.to_s)
        end
      end
    end
  end
end
