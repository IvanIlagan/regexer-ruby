# frozen_string_literal: true

require "regexer/utils/handlers/single_entity_checker_value_handlers/string_handler"
require "regexer/utils/handlers/single_entity_checker_value_handlers/number_handler"
require "regexer/utils/handlers/single_entity_checker_value_handlers/pattern_object_handler"

module Regexer
  module Utils
    # A Utility Class that checks if a value is a single entity or not
    class SingleEntityChecker
      def self.single_entity?(value)
        string_handler = ::Regexer::Utils::Handlers::SingleEntityCheckerValueHandler::StringHandler.new
        number_handler = ::Regexer::Utils::Handlers::SingleEntityCheckerValueHandler::NumberHandler.new
        pattern_object_handler = ::Regexer::Utils::Handlers::SingleEntityCheckerValueHandler::PatternObjectHandler.new

        string_handler.next_handler(number_handler)
                      .next_handler(pattern_object_handler)

        string_handler.handle(value) || false
      end
    end
  end
end
