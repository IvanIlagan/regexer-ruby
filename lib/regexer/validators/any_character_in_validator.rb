# frozen_string_literal: true

require "regexer/exceptions/invalid_value_error"
require "regexer/models/character_range_pattern"

module Regexer
  module Validators
    # A Validator Class for validating values being passed to has_any_character_in Regexer::Pattern method
    class AnyCharacterInValidator
      def self.value_valid?(value)
        char_range_model = "Regexer::Models::CharacterRangePattern"
        valid_hash_model = "Hash with from & to keys"
        valid_basic_types = "String or Integer or Float"
        message = "Value should only be of type #{valid_basic_types} or #{char_range_model} or #{valid_hash_model}"
        raise Regexer::Exceptions::InvalidValueError, message unless valid?(value)
      end

      class << self
        private

        def number?(value)
          value.instance_of?(Integer) || value.instance_of?(Float)
        end

        def string?(value)
          value.instance_of?(String)
        end

        def from_to_hash?(value)
          value.instance_of?(Hash) && value.keys == %i[from to]
        end

        def character_range?(value)
          value.instance_of?(Regexer::Models::CharacterRangePattern)
        end

        def valid?(value)
          number?(value) || string?(value) || character_range?(value) || from_to_hash?(value)
        end
      end
    end
  end
end
