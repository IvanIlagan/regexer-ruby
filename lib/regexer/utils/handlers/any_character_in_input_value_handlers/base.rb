# frozen_string_literal: true

require "regexer/utils/handlers/base_handler"

module Regexer
  module Utils
    module Handlers
      module AnyCharacterInInputValueHandlers
        # The base class for the handling of input values of
        # has_any_character_in method
        class Base < ::Regexer::Utils::Handlers::BaseHandler
          def next_handler(handler)
            @next_handler = handler

            handler
          end

          def give_to_next_handler(value)
            @next_handler&.handle(value) if @next_handler
          end
        end
      end
    end
  end
end
