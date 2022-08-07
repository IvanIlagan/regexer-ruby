# frozen_string_literal: true

require "regexer/utils/handlers/quantifier_options_handlers/base"
require "regexer/validators/consecutive_instances_of_options_value_validator"

module Regexer
  module Utils
    module Handlers
      module QuantifierOptionsHandler
        # A handler class to return the appropriate quantifier value
        # if given the minimum & maximum options only
        class MinMaxOptionHandler < Base
          def handle(value)
            if value.maximum
              raise ArgumentError, "missing minimum keyword argument" unless value.minimum

              Regexer::Validators::ConsecutiveInstancesOfOptionsValueValidator.value_valid?(value.minimum)
              Regexer::Validators::ConsecutiveInstancesOfOptionsValueValidator.value_valid?(value.maximum)
              Regexer::Validators::ConsecutiveInstancesOfOptionsValueValidator
                .min_max_range_valid?(value.minimum, value.maximum)

              "{#{value.minimum},#{value.maximum}}"
            else
              give_to_next_handler(value)
            end
          end
        end
      end
    end
  end
end
