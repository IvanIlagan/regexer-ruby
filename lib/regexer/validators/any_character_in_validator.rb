# frozen_string_literal: true

require "regexer/exceptions/invalid_value_error"
require "regexer/models/pattern"

module Regexer
  module Validators
    # A Validator Class for validating values being passed to has_any_character_in Regexer::Pattern method
    class AnyCharacterInValidator
      def self.value_valid?(value)
        error_message = "Value should only be of type String or Integer or Hash with from & to keys"
        raise Regexer::Exceptions::InvalidValueError, error_message unless valid?(value)
      end

      def self.number?(value)
        value.instance_of?(Integer) || value.instance_of?(Float)
      end

      def self.string?(value)
        value.instance_of?(String)
      end

      def self.from_to_hash?(value)
        value.instance_of?(Hash) && value.keys == %i[from to]
      end

      class << self
        private

        def valid?(value)
          number?(value) || string?(value) || from_to_hash?(value)
        end
      end
    end
  end
end
