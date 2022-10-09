# frozen_string_literal: true

require "regexer/utils/handlers/any_character_in_input_value_handlers/base"
require "regexer/utils/pattern_sanitizer"

module Regexer
  module Utils
    module Handlers
      module AnyCharacterInInputValueHandlers
        # A handler class to check if input value is one of the valid
        # basic data types e.g. String, Integer, Float
        # If its one of the basic types, just return a sanitized
        # value for regex
        class BasicTypesHandler < Base
          def handle(value)
            if value.instance_of?(String) || value.instance_of?(Integer) || value.instance_of?(Float)
              Regexer::Utils::PatternSanitizer.sanitize(value)
            else
              give_to_next_handler(value)
            end
          end
        end
      end
    end
  end
end
