# frozen_string_literal: true

require "regexer/exceptions/invalid_value_error"

module Regexer
  module Validators
    # A Validator Class for validating if a value is an integer from 0 - 9
    class NumberValidator
      def self.number?(value)
        error_message = "Value should only be an integer from 0 to 9"
        raise Regexer::Exceptions::InvalidValueError, error_message unless integer?(value) && in_0_to_9?(value)
      end

      class << self
        private

        def integer?(value)
          value.instance_of?(Integer)
        end

        def in_0_to_9?(value)
          (0..9).to_a.include?(value)
        end
      end
    end
  end
end
