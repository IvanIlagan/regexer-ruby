# frozen_string_literal: true

module Regexer
  module Models
    # The main model for character range patterns
    class CharacterRangePattern
      attr_reader :from, :to

      def initialize(from, to)
        @from = Regexp.escape(from)
        @to = Regexp.escape(to)
      end
    end
  end
end
