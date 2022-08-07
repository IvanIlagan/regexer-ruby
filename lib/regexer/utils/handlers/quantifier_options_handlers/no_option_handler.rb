# frozen_string_literal: true

require "regexer/utils/handlers/quantifier_options_handlers/base"
require "regexer/validators/consecutive_instances_of_options_value_validator"

module Regexer
  module Utils
    module Handlers
      module QuantifierOptionsHandler
        # A handler class to return the appropriate quantifier value
        # if given no options
        class NoOptionHandler < Base
          def handle(value)
            if !value.exactly && !value.minimum && !value.maximum
              "+"
            else
              give_to_next_handler(value)
            end
          end
        end
      end
    end
  end
end
