# frozen_string_literal: true

require "regexer/exceptions/invalid_value_error"

module Regexer
  module Validators
    # A Validator Class for validating option values being passed to consecutive_instances_of Regexer::Pattern method
    class ConsecutiveInstancesOfOptionsValueValidator
      def self.value_valid?(value)
        error_message = "Value should only be of type Integer"

        raise Regexer::Exceptions::InvalidValueError, error_message unless integer?(value)
      end

      def self.min_max_range_valid?(min_value, max_value)
        error_message = "minimum value is larger than maximum value"

        raise RangeError, error_message unless min_value < max_value
      end

      def self.integer?(value)
        value.instance_of?(Integer)
      end
    end
  end
end
