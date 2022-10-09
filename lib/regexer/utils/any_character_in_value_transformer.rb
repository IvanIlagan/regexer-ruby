# frozen_string_literal: true

require "regexer/utils/handlers/any_character_in_input_value_handlers/base"
require "regexer/utils/handlers/any_character_in_input_value_handlers/basic_types_handler"
require "regexer/utils/handlers/any_character_in_input_value_handlers/character_range_pattern_handler"
require "regexer/utils/handlers/any_character_in_input_value_handlers/from_to_hash_handler"

module Regexer
  module Utils
    # A Utility Class that transforms a given value based on
    # its types so that it is compatible with the
    # has_any_character_in or has_any_character_not_in methods
    class AnyCharacterInValueTransformer
      def self.transform(value)
        basic_types_handler = ::Regexer::Utils::Handlers::AnyCharacterInInputValueHandlers::BasicTypesHandler.new
        char_range_pattern_handler =
          ::Regexer::Utils::Handlers::AnyCharacterInInputValueHandlers::CharacterRangePatternHandler.new
        from_to_hash_handler = ::Regexer::Utils::Handlers::AnyCharacterInInputValueHandlers::FromToHashHandler.new

        basic_types_handler.next_handler(char_range_pattern_handler)
                           .next_handler(from_to_hash_handler)

        basic_types_handler.handle(value) || ""
      end
    end
  end
end
