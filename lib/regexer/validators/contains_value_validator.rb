# frozen_string_literal: true

require "regexer/exceptions/invalid_value_error"

module Regexer
  module Validators
    # A Validator Class for validating values being passed to contains Regexer::Pattern method
    class ContainsValueValidator
      def self.value_valid?(value)
        error_message = "Value should only be of type String or Integer or Float"
        raise Regexer::Exceptions::InvalidValueError, error_message unless number?(value) || string?(value)
      end

      def self.number?(value)
        value.instance_of?(Integer) || value.instance_of?(Float)
      end

      def self.string?(value)
        value.instance_of?(String)
      end
    end
  end
end
