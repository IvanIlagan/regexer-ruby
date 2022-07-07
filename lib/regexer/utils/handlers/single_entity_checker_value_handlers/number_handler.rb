# frozen_string_literal: true

require "regexer/utils/handlers/single_entity_checker_value_handlers/base"

module Regexer
  module Utils
    module Handlers
      module SingleEntityCheckerValueHandler
        # A handler class to check if a number is considered as single entity or not
        # if this handler sees that the value is not a number, it will then pass it to
        # the next handler
        class NumberHandler < Base
          def handle(value)
            if value.instance_of?(Integer)
              value.digits.length == 1
            else
              give_to_next_handler(value)
            end
          end
        end
      end
    end
  end
end
