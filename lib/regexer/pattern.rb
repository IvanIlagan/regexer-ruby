# frozen_string_literal: true

module Regexer
  # A Class that contains core methods for building regex patterns
  class Pattern
    def initialize
      @result_pattern = ""
    end

    def regex(&block)
      instance_exec(&block)
      /#{@result_pattern}/
    end

    private

    def has_letters(**kwargs)
      pattern = "[#{kwargs[:from]}-#{kwargs[:to]}]+"
      pattern.gsub!("+", "*") if kwargs[:optional]
      @result_pattern += pattern
    end

    def has_numbers(**kwargs)
      pattern = "[#{kwargs[:from]}-#{kwargs[:to]}]+"
      pattern.gsub!("+", "*") if kwargs[:optional]
      @result_pattern += pattern
    end

    def contains(value, **kwargs)
      pattern = "#{value}+"
      pattern = pattern[0..-2] if kwargs[:one?]
      pattern = "#{pattern[0..-2]}*" if kwargs[:optional]
      @result_pattern += pattern
    end
  end
end
