# frozen_string_literal: true

module Regexer
  module Models
    # The main model for the patterns being build by pattern builder
    class Pattern
      attr_reader :raw_pattern

      def initialize(pattern, regex_escaped: true)
        @raw_pattern = pattern
        @regex_escaped = regex_escaped
      end

      def regex_escaped?
        @regex_escaped
      end

      def regex
        /#{raw_pattern}/
      end
    end
  end
end
