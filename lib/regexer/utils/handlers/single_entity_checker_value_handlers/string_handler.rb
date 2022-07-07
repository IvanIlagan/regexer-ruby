# frozen_string_literal: true

require "regexer/utils/handlers/single_entity_checker_value_handlers/base"

module Regexer
  module Utils
    module Handlers
      module SingleEntityCheckerValueHandler
        # A handler class to check if a string value is considered as single entity or not
        # if this handler sees that the value is not a string, it will then pass it to
        # the next handler
        class StringHandler < Base
          def handle(value)
            if value.instance_of?(String)
              value.length == 1
            else
              give_to_next_handler(value)
            end
          end
        end
      end
    end
  end
end
