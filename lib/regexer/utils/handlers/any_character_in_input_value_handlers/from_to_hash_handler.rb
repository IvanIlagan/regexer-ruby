# frozen_string_literal: true

require "regexer/utils/handlers/any_character_in_input_value_handlers/base"
require "regexer/models/character_range_pattern"
require "regexer/validators/from_to_validator"

module Regexer
  module Utils
    module Handlers
      module AnyCharacterInInputValueHandlers
        # A handler class to check if input value is a Hash with from & to keys only
        # if true, should return a regex escaped string based on values in that Hash
        class FromToHashHandler < Base
          def handle(value)
            if value.instance_of?(Hash) && value.keys == %i[from to]
              Regexer::Validators::FromToValidator.valid_values?("ascii_character", value[:from], value[:to])
              "#{Regexp.escape(value[:from])}-#{Regexp.escape(value[:to])}"
            else
              give_to_next_handler(value)
            end
          end
        end
      end
    end
  end
end
