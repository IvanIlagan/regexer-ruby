# frozen_string_literal: true

require "regexer/utils/handlers/quantifier_options_handlers/base"
require "regexer/validators/consecutive_instances_of_options_value_validator"

module Regexer
  module Utils
    module Handlers
      module QuantifierOptionsHandler
        # A handler class to return the appropriate quantifier value
        # if given the exactly option
        class ExactlyOptionHandler < Base
          def handle(value)
            if value.exactly
              Regexer::Validators::ConsecutiveInstancesOfOptionsValueValidator.value_valid?(value.exactly)
              "{#{value.exactly}}"
            else
              give_to_next_handler(value)
            end
          end
        end
      end
    end
  end
end
