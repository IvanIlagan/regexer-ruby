# frozen_string_literal: true

require "regexer/utils/handlers/quantifier_options_handlers/exactly_option_handler"
require "regexer/utils/handlers/quantifier_options_handlers/minimum_option_handler"
require "regexer/utils/handlers/quantifier_options_handlers/min_max_option_handler"
require "regexer/utils/handlers/quantifier_options_handlers/no_option_handler"

module Regexer
  module Utils
    # A Utility Class that generates a quantifier value based on
    # the given options
    class QuantifierValueGenerator
      def self.generate(value)
        exactly_option_handler = ::Regexer::Utils::Handlers::QuantifierOptionsHandler::ExactlyOptionHandler.new
        minimum_option_handler = ::Regexer::Utils::Handlers::QuantifierOptionsHandler::MinimumOptionHandler.new
        min_max_option_handler = ::Regexer::Utils::Handlers::QuantifierOptionsHandler::MinMaxOptionHandler.new
        no_option_handler = ::Regexer::Utils::Handlers::QuantifierOptionsHandler::NoOptionHandler.new

        exactly_option_handler.next_handler(minimum_option_handler)
                              .next_handler(min_max_option_handler)
                              .next_handler(no_option_handler)

        exactly_option_handler.handle(value) || ""
      end
    end
  end
end
