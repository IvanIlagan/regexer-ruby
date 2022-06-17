# frozen_string_literal: true

require "regexer/validators/from_to_validator"
require "regexer/validators/letter_validator"
require "regexer/validators/number_validator"
require "regexer/validators/contains_value_validator"
require "regexer/models/pattern"
require "pry"

module Regexer
  # A Class that contains core methods for building regex patterns
  class PatternBuilder
    def initialize(&block)
      @final_pattern = ""
      instance_exec(&block)
    end

    def result
      Regexer::Models::Pattern.new(@final_pattern)
    end

    private

    def has_consecutive(value)
      pattern = extract_pattern(value)

      pattern_object = Regexer::Models::Pattern.new(append_character_in_pattern(pattern, "+", -1))
      update_final_pattern(pattern, pattern_object.raw_pattern)
      pattern_object
    end

    def has_none_or_consecutive(value)
      pattern = extract_pattern(value)

      pattern_object = Regexer::Models::Pattern.new(append_character_in_pattern(pattern, "*", -1))
      update_final_pattern(pattern, pattern_object.raw_pattern)
      pattern_object
    end

    # BASE PATTERNS
    def has_letter(from:, to:)
      Regexer::Validators::LetterValidator.letter?(from)
      Regexer::Validators::LetterValidator.letter?(to)
      Regexer::Validators::FromToValidator.validate_range(from, to)
      pattern_object = Regexer::Models::Pattern.new("[#{from}-#{to}]")
      @final_pattern += pattern_object.raw_pattern
      pattern_object
    end

    def has_number(from:, to:)
      Regexer::Validators::NumberValidator.number?(from)
      Regexer::Validators::NumberValidator.number?(to)
      Regexer::Validators::FromToValidator.validate_range(from, to)
      pattern_object = Regexer::Models::Pattern.new("[#{from}-#{to}]")
      @final_pattern += pattern_object.raw_pattern
      pattern_object
    end

    def contains(value)
      Regexer::Validators::ContainsValueValidator.value_valid?(value)
      sanitized_pattern = sanitize_pattern(value)
      pattern_object = Regexer::Models::Pattern.new("(#{sanitized_pattern})")
      update_final_pattern(sanitized_pattern, pattern_object.raw_pattern)
      pattern_object
    end

    def starts_with(value)
      Regexer::Validators::ContainsValueValidator.value_valid?(value)
      sanitized_pattern = sanitize_pattern(value)
      pattern_object = Regexer::Models::Pattern.new("^(#{sanitized_pattern})")
      update_final_pattern(sanitized_pattern, pattern_object.raw_pattern)
      pattern_object
    end

    def ends_with(value)
      Regexer::Validators::ContainsValueValidator.value_valid?(value)
      sanitized_pattern = sanitize_pattern(value)
      pattern_object = Regexer::Models::Pattern.new("(#{sanitized_pattern})$")
      update_final_pattern(sanitized_pattern, pattern_object.raw_pattern)
      pattern_object
    end

    def has_word_character
      pattern_object = Regexer::Models::Pattern.new("\\w")
      @final_pattern += pattern_object.raw_pattern
      pattern_object
    end

    # UTILITIES
    def append_character_in_pattern(pattern, character_to_insert, index)
      String.new(pattern).insert(index, character_to_insert)
    end

    def extract_pattern(value)
      if value.instance_of?(Regexer::Models::Pattern)
        value.raw_pattern
      else
        contains(value)&.raw_pattern
      end
    end

    def sanitize_pattern(value)
      if value.instance_of?(Regexer::Models::Pattern)
        sanitize_pattern(value.raw_pattern) unless value.regex_escaped?
        value.raw_pattern
      else
        Regexp.escape(value.to_s)
      end
    end

    def update_final_pattern(previous_appended_pattern, new_pattern)
      previous_appended_pattern_regex = /(#{Regexp.escape(previous_appended_pattern)})$/

      if @final_pattern.match?(previous_appended_pattern_regex)
        @final_pattern.sub!(previous_appended_pattern_regex, new_pattern)
      else
        @final_pattern += new_pattern
      end
    end

    alias word_character has_word_character
    alias letter has_letter
    alias number has_number
    alias consecutive has_consecutive
    alias none_or_consecutive has_none_or_consecutive
  end
end
