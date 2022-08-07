module Regexer
  module Utils
    # A Utility Class that contains helper methods
    # in dealing with strings
    class StringHelper
      def self.update_string_pattern(pattern_to_update, previous_appended_pattern, new_pattern)
        if !previous_appended_pattern.empty? && pattern_to_update.end_with?(previous_appended_pattern)
          pattern_to_update.sub!(/(#{Regexp.escape(previous_appended_pattern)})$/) { new_pattern }
        else
          pattern_to_update << new_pattern
        end
      end
    end
  end
end
