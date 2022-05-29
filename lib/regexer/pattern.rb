# frozen_string_literal: true

require "regexer/validators/from_to_validator"
require "regexer/validators/letter_validator"
require "regexer/validators/number_validator"
require "regexer/validators/contains_value_validator"
require "pry"

module Regexer
  # A Class that contains core methods for building regex patterns
  class Pattern
    def initialize(&block)
      @patterns = []
      instance_exec(&block)
    end

    def build_regex
      /#{@patterns.join}/
    end

    private

    def has_none_or_more_letters(from:, to:)
      has_letters(from: from, to: to)
      @patterns[-1] = append_character_in_pattern(@patterns.last, "*", -1)
    end

    def has_none_or_more_numbers(from:, to:)
      has_numbers(from: from, to: to)
      @patterns[-1] = append_character_in_pattern(@patterns.last, "*", -1)
    end

    def contains_none_or_consecutive(value)
      contains(value)
      @patterns[-1] = append_character_in_pattern(@patterns.last, "*", -1)
    end

    def starts_with_none_or_consecutive(value)
      starts_with(value)
      @patterns[-1] = append_character_in_pattern(@patterns.last, "*", -1)
    end

    def ends_with_none_or_consecutive(value)
      ends_with(value)
      @patterns[-1] = append_character_in_pattern(@patterns.last, "*", -2)
    end

    def has_consecutive_letters(from:, to:)
      has_letters(from: from, to: to)
      @patterns[-1] = append_character_in_pattern(@patterns.last, "+", -1)
    end

    def has_consecutive_numbers(from:, to:)
      has_numbers(from: from, to: to)
      @patterns[-1] = append_character_in_pattern(@patterns.last, "+", -1)
    end

    def contains_consecutive(value)
      contains(value)
      @patterns[-1] = append_character_in_pattern(@patterns.last, "+", -1)
    end

    def starts_with_consecutive(value)
      starts_with(value)
      @patterns[-1] = append_character_in_pattern(@patterns.last, "+", -1)
    end

    def ends_with_consecutive(value)
      ends_with(value)
      @patterns[-1] = append_character_in_pattern(@patterns.last, "+", -2)
    end

    def has_letters(from:, to:)
      Regexer::Validators::LetterValidator.letter?(from)
      Regexer::Validators::LetterValidator.letter?(to)
      Regexer::Validators::FromToValidator.validate_range(from, to)
      @patterns.push("[#{from}-#{to}]")
    end

    def has_numbers(from:, to:)
      Regexer::Validators::NumberValidator.number?(from)
      Regexer::Validators::NumberValidator.number?(to)
      Regexer::Validators::FromToValidator.validate_range(from, to)
      @patterns.push("[#{from}-#{to}]")
    end

    def contains(value)
      Regexer::Validators::ContainsValueValidator.value_valid?(value)
      @patterns.push("(#{Regexp.escape(value.to_s)})")
    end

    def starts_with(value)
      Regexer::Validators::ContainsValueValidator.value_valid?(value)
      pattern = Regexp.escape(value.to_s)
      @patterns.push("^(#{pattern})")
    end

    def ends_with(value)
      Regexer::Validators::ContainsValueValidator.value_valid?(value)
      pattern = Regexp.escape(value.to_s)
      @patterns.push("(#{pattern})$")
    end

    def append_character_in_pattern(pattern, character_to_insert, index)
      pattern.insert(index, character_to_insert)
    end
  end
end
