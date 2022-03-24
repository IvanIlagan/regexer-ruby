# frozen_string_literal: true

require "regexer/exceptions/invalid_value_error"

module Regexer
  module Validators
    # A Validator Class for validating values being passed to contains Regexer::Pattern method
    class ContainsValueValidator
      def self.value_valid?(value)
        error_message = "Value should only be of type String or Integer"
        raise Regexer::Exceptions::InvalidValueError, error_message unless integer?(value) || string?(value)
      end

      def self.integer?(value)
        value.instance_of?(Integer)
      end

      def self.string?(value)
        value.instance_of?(String)
      end
    end
  end
end