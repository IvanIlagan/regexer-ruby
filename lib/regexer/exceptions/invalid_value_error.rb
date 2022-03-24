# frozen_string_literal: true

module Regexer
  module Exceptions
    # An Exception Class For General Invalid Value Errors
    class InvalidValueError < StandardError
      def initialize(message = nil)
        super(message)
      end
    end
  end
end
