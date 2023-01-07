# frozen_string_literal: true

require "regexer/utils/handlers/any_character_in_input_value_handlers/base"
require "regexer/models/pattern"

module Regexer
  module Utils
    module Handlers
      module AnyCharacterInInputValueHandlers
        # A handler class to check if input value is a Regexer::Models::Pattern object
        # tagged as regex shorthand character
        # this returns the raw_pattern of that object
        class RegexShorthandPatternHandler < Base
          def handle(value)
            if value.instance_of?(Regexer::Models::Pattern) && value.regex_shorthand_character?
              value.raw_pattern
            else
              give_to_next_handler(value)
            end
          end
        end
      end
    end
  end
end
