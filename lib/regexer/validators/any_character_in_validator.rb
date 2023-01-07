# frozen_string_literal: true

require "regexer/exceptions/invalid_value_error"
require "regexer/models/character_range_pattern"
require "regexer/models/pattern"

module Regexer
  module Validators
    # A Validator Class for validating values being passed to has_any_character_in Regexer::Pattern method
    class AnyCharacterInValidator
      def self.value_valid?(value)
        char_range = "Regexer::Models::CharacterRangePattern"
        regex_shorthand_pattern = "Regexer::Models::Pattern as regex shorthand character"
        hash_model = "Hash with from & to keys"
        basic_types = "String, Integer, Float"
        message = "Value should be one of type #{basic_types}, #{char_range}, #{hash_model}, #{regex_shorthand_pattern}"
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

        def regex_shorthand_character_pattern?(value)
          value.instance_of?(Regexer::Models::Pattern) && value.regex_shorthand_character?
        end

        def valid?(value)
          number?(value) ||
            string?(value) ||
            character_range?(value) ||
            from_to_hash?(value) ||
            regex_shorthand_character_pattern?(value)
        end
      end
    end
  end
end
