# frozen_string_literal: true

module Regexer
  module Utils
    module Handlers
      # A Base interface class for handlers
      class BaseHandler
        def handle
          raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
        end

        def next_handler(_handler)
          raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
        end
      end
    end
  end
end
