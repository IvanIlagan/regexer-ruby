# frozen_string_literal: true

require "regexer/utils/handlers/any_character_in_input_value_handlers/base"
require "regexer/utils/handlers/any_character_in_input_value_handlers/basic_types_handler"
require "regexer/utils/handlers/any_character_in_input_value_handlers/character_range_pattern_handler"
require "regexer/utils/handlers/any_character_in_input_value_handlers/from_to_hash_handler"
require "regexer/utils/handlers/any_character_in_input_value_handlers/regex_shorthand_pattern_handler"

module Regexer
  module Utils
    # A Utility Class that transforms a given value based on
    # its types so that it is compatible with the
    # has_any_character_in or has_any_character_not_in methods
    class AnyCharacterInValueTransformer
      def self.transform(value)
        basic_types_handler = ::Regexer::Utils::Handlers::AnyCharacterInInputValueHandlers::BasicTypesHandler.new
        from_to_hash_handler = ::Regexer::Utils::Handlers::AnyCharacterInInputValueHandlers::FromToHashHandler.new
        char_range_pattern_handler =
          ::Regexer::Utils::Handlers::AnyCharacterInInputValueHandlers::CharacterRangePatternHandler.new
        regex_shorthand_pattern_handler =
          ::Regexer::Utils::Handlers::AnyCharacterInInputValueHandlers::RegexShorthandPatternHandler.new

        basic_types_handler.next_handler(char_range_pattern_handler)
                           .next_handler(from_to_hash_handler)
                           .next_handler(regex_shorthand_pattern_handler)

        basic_types_handler.handle(value) || ""
      end
    end
  end
end
