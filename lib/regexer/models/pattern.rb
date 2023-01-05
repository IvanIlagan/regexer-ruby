# frozen_string_literal: true

require "regexer/exceptions/invalid_value_error"

module Regexer
  module Models
    # The main model for the patterns being build by pattern builder
    class Pattern
      attr_reader :raw_pattern

      def initialize(pattern, regex_escaped: true, single_entity: true)
        @raw_pattern = String.new(pattern)
        @regex_escaped = regex_escaped
        @single_entity = single_entity
      end

      def +(other)
        unless other.is_a?(Regexer::Models::Pattern)
          raise TypeError,
                "Unable to add #{other.class} to Regexer::Models::Pattern"
        end

        Regexer::Models::Pattern.new(@raw_pattern + other.raw_pattern, regex_escaped: @regex_escaped,
                                                                       single_entity: @single_entity)
      end

      def regex_escaped?
        @regex_escaped
      end

      def single_entity?
        @single_entity
      end

      def regex
        /#{raw_pattern}/
      end
    end
  end
end
