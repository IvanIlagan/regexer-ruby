# frozen_string_literal: true

require "regexer/exceptions/invalid_value_error"

module Regexer
  module Validators
    # A Validator Class for validating if a value is a single letter
    class AsciiCharacterValidator
      def self.ascii_character?(value)
        error_message = "Value should only be a single character in the ascii table"
        raise Regexer::Exceptions::InvalidValueError, error_message unless string?(value) && single_ascii_letter?(value)
      end

      class << self
        private

        def string?(value)
          value.instance_of?(String)
        end

        def single_ascii_letter?(value)
          value.length == 1 && value.match?(/[[:ascii:]]/)
        end
      end
    end
  end
end
