# frozen_string_literal: true

module Regexer
  module Exceptions
    # An Exception Class For no block given error
    class NoBlockGivenError < StandardError
      def initialize(message = nil)
        super(message)
      end
    end
  end
end
