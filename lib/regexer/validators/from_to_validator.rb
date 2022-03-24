# frozen_string_literal: true

require "regexer/exceptions/invalid_from_to_range_error"

module Regexer
  module Validators
    # A Validator Class for validating range values in Regexer::Pattern methods
    # that takes in from and to values as method arguments
    class FromToValidator
      def self.validate_range(from_value, to_value)
        raise Regexer::Exceptions::InvalidFromToRangeError if from_value > to_value
      end
    end
  end
end
