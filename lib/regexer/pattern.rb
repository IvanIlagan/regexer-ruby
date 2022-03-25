# frozen_string_literal: true

require "regexer/validators/from_to_validator"
require "regexer/validators/letter_validator"
require "regexer/validators/number_validator"
require "regexer/validators/contains_value_validator"

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

    def has_letters(from:, to:, optional: false)
      Regexer::Validators::LetterValidator.letter?(from)
      Regexer::Validators::LetterValidator.letter?(to)
      Regexer::Validators::FromToValidator.validate_range(from, to)
      pattern = "[#{from}-#{to}]+"
      pattern.gsub!("+", "*") if optional
      @result_pattern += pattern
    end

    def has_numbers(from:, to:, optional: false)
      Regexer::Validators::NumberValidator.number?(from)
      Regexer::Validators::NumberValidator.number?(to)
      Regexer::Validators::FromToValidator.validate_range(from, to)
      pattern = "[#{from}-#{to}]+"
      pattern.gsub!("+", "*") if optional
      @result_pattern += pattern
    end

    def contains(value)
      Regexer::Validators::ContainsValueValidator.value_valid?(value)
      pattern = Regexp.escape(value.to_s)
      @result_pattern += pattern
    end
  end
end
