# frozen_string_literal: true

require "regexer/utils/handlers/single_entity_checker_value_handlers/base"

module Regexer
  module Utils
    module Handlers
      module SingleEntityCheckerValueHandler
        # A handler class to check if a pattern object is considered as single entity or not
        # if this handler sees that the value is not a pattern object, it will then pass it to
        # the next handler
        class PatternObjectHandler < Base
          def handle(value)
            if value.instance_of?(::Regexer::Models::Pattern)
              value.single_entity?
            else
              give_to_next_handler(value)
            end
          end

          private

          def wrapped_in_parentheses?(value)
            value.raw_pattern[0] == "(" && value.raw_pattern[-1] == ")"
          end

          def wrapped_in_square_brackets?(value)
            value.raw_pattern[0] == "[" && value.raw_pattern[-1] == "]"
          end
        end
      end
    end
  end
end
