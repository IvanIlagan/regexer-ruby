# frozen_string_literal: true

require "regexer/validators/letter_validator"
require "regexer/validators/number_validator"
require "regexer/validators/ascii_character_validator"

module Regexer
  module Validators
    # A Validator Class for validating range values in Regexer::Pattern methods
    # that takes in from and to values as method arguments
    class FromToValidator
      def self.valid_values?(value_type, from_value, to_value)
        case value_type
        when "number"
          Regexer::Validators::NumberValidator.number?(from_value)
          Regexer::Validators::NumberValidator.number?(to_value)
        when "letter"
          Regexer::Validators::LetterValidator.letter?(from_value)
          Regexer::Validators::LetterValidator.letter?(to_value)
        when "ascii_character"
          Regexer::Validators::AsciiCharacterValidator.ascii_character?(from_value)
          Regexer::Validators::AsciiCharacterValidator.ascii_character?(to_value)
        end

        validate_range(from_value, to_value)
      end

      private_class_method def self.validate_range(from_value, to_value)
        raise RangeError, "From value is greater than the To value" if from_value > to_value
      end
    end
  end
end
