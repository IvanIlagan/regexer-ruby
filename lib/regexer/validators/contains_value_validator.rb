# frozen_string_literal: true

require "regexer/exceptions/invalid_value_error"
require "regexer/models/pattern"

module Regexer
  module Validators
    # A Validator Class for validating values being passed to contains Regexer::Pattern method
    class ContainsValueValidator
      def self.value_valid?(value)
        error_message = "Value should only be of type String or Integer or Float or Regexer::Models::Pattern"
        raise Regexer::Exceptions::InvalidValueError, error_message unless valid?(value)
      end

      def self.number?(value)
        value.instance_of?(Integer) || value.instance_of?(Float)
      end

      def self.string?(value)
        value.instance_of?(String)
      end

      def self.pattern?(value)
        value.instance_of?(Regexer::Models::Pattern)
      end

      class << self
        private

        def valid?(value)
          number?(value) || string?(value) || pattern?(value)
        end
      end
    end
  end
end
