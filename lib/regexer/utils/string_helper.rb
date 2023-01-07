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

      def self.remove_pattern_in_the_end_of_string(pattern_to_update, pattern_to_remove)
        pattern_to_update
          .sub!(/(#{Regexp.escape(pattern_to_remove)})$/) { "" } if pattern_to_update.end_with?(pattern_to_remove)
      end
    end
  end
end
