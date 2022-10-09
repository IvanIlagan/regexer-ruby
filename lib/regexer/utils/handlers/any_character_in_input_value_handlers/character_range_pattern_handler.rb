# frozen_string_literal: true

require "regexer/utils/handlers/any_character_in_input_value_handlers/base"
require "regexer/models/character_range_pattern"

module Regexer
  module Utils
    module Handlers
      module AnyCharacterInInputValueHandlers
        # A handler class to check if input value is a CharacterRangePattern object
        # if true, should return a string based on values in that object
        class CharacterRangePatternHandler < Base
          def handle(value)
            if value.instance_of?(Regexer::Models::CharacterRangePattern)
              "#{value.from}-#{value.to}"
            else
              give_to_next_handler(value)
            end
          end
        end
      end
    end
  end
end
