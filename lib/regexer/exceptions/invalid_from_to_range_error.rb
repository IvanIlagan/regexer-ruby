# frozen_string_literal: true

module Regexer
  module Exceptions
    # An Exception Class For Invalid From To Range Value Errors
    class InvalidFromToRangeError < StandardError
      def initialize(_message = nil)
        super("From value is greater than the To value")
      end
    end
  end
end
