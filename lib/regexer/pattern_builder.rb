# frozen_string_literal: true

require "regexer/validators/from_to_validator"
require "regexer/validators/letter_validator"
require "regexer/validators/number_validator"
require "regexer/validators/contains_value_validator"
require "regexer/validators/ascii_character_validator"
require "regexer/validators/any_character_in_validator"
require "regexer/exceptions/no_block_given_error"
require "regexer/models/pattern"
require "regexer/utils/single_entity_checker"
require "pry"

module Regexer
  # A Class that contains core methods for building regex patterns
  class PatternBuilder
    def initialize(&block)
      @final_pattern = ""
      instance_exec(&block)
    end

    def result
      Regexer::Models::Pattern.new(@final_pattern, single_entity: false)
    end

    private

    # SPECIAL FUNCTION CHARACTERS
    # MOSTLY IMPLEMENTATION OF SPECIAL CHARACTERS IN REGEX
    def starts_with(value)
      pattern = contains(value)&.raw_pattern

      pattern_object = Regexer::Models::Pattern.new(insert_character_in_pattern(pattern, "^", 0), single_entity: false)
      update_final_pattern(pattern, pattern_object.raw_pattern)
      pattern_object
    end

    def ends_with(value)
      pattern = contains(value)&.raw_pattern

      pattern_object = Regexer::Models::Pattern.new(insert_character_in_pattern(pattern, "$", -1), single_entity: false)
      update_final_pattern(pattern, pattern_object.raw_pattern)
      pattern_object
    end

    # REGEX QUANTIFIERS
    def has_consecutive(value)
      pattern = contains(value)&.raw_pattern

      pattern_object = Regexer::Models::Pattern.new(insert_character_in_pattern(pattern, "+", -1), single_entity: false)
      update_final_pattern(pattern, pattern_object.raw_pattern)
      pattern_object
    end

    def has_none_or_consecutive(value)
      pattern = contains(value)&.raw_pattern

      pattern_object = Regexer::Models::Pattern.new(insert_character_in_pattern(pattern, "*", -1), single_entity: false)
      update_final_pattern(pattern, pattern_object.raw_pattern)
      pattern_object
    end

    # BASIC EASE OF USE PATTERNS
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

    def has_ascii_character(from:, to:)
      Regexer::Validators::AsciiCharacterValidator.ascii_character?(from)
      Regexer::Validators::AsciiCharacterValidator.ascii_character?(to)
      Regexer::Validators::FromToValidator.validate_range(from, to)
      pattern_object = Regexer::Models::Pattern.new("[#{Regexp.escape(from)}-#{Regexp.escape(to)}]")
      @final_pattern += pattern_object.raw_pattern
      pattern_object
    end

    def has_word_character
      pattern_object = Regexer::Models::Pattern.new("\\w")
      @final_pattern += pattern_object.raw_pattern
      pattern_object
    end

    def contains(value)
      Regexer::Validators::ContainsValueValidator.value_valid?(value)

      sanitized_pattern = sanitize_pattern(value)

      pattern_object = if ::Regexer::Utils::SingleEntityChecker.single_entity?(value)
                         Regexer::Models::Pattern.new(sanitized_pattern)
                       else
                         Regexer::Models::Pattern.new("(#{sanitized_pattern})")
                       end

      update_final_pattern(pattern_object?(value) ? sanitized_pattern : "", pattern_object.raw_pattern)
      pattern_object
    end

    def has_group(&block)
      raise Regexer::Exceptions::NoBlockGivenError unless block_given?

      value = Regexer::PatternBuilder.new(&block).result
      sanitized_pattern = sanitize_pattern(value)
      pattern_object = Regexer::Models::Pattern.new("(#{sanitized_pattern})")
      update_final_pattern(sanitized_pattern, pattern_object.raw_pattern)
      pattern_object
    end

    def has_any_character_in(*values)
      combined_pattern = values.reduce("") do |pattern, value|
        Regexer::Validators::AnyCharacterInValidator.value_valid?(value)
        if value.instance_of?(Hash)
          Regexer::Validators::AsciiCharacterValidator.ascii_character?(value[:from])
          Regexer::Validators::AsciiCharacterValidator.ascii_character?(value[:to])
          Regexer::Validators::FromToValidator.validate_range(value[:from], value[:to])
          pattern + "#{value[:from]}-#{value[:to]}"
        else
          pattern + sanitize_pattern(value)
        end
      end

      pattern_object = Regexer::Models::Pattern.new("[#{combined_pattern}]")
      @final_pattern += pattern_object.raw_pattern
      pattern_object
    end

    # VALUE BUILDER METHOD THAT IS COMPATIBILE WITH THE PATTERN BUILDER
    def character_range(from:, to:)
      Regexer::Validators::AsciiCharacterValidator.ascii_character?(from)
      Regexer::Validators::AsciiCharacterValidator.ascii_character?(to)
      Regexer::Validators::FromToValidator.validate_range(from, to)
      { from: Regexp.escape(from), to: Regexp.escape(to) }
    end

    # UTILITIES
    def insert_character_in_pattern(pattern, character_to_insert, index)
      String.new(pattern).insert(index, character_to_insert)
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
      if !previous_appended_pattern.empty? && @final_pattern.end_with?(previous_appended_pattern)
        @final_pattern.sub!(/(#{Regexp.escape(previous_appended_pattern)})$/) { new_pattern }
      else
        @final_pattern += new_pattern
      end
    end

    def pattern_object?(value)
      value.instance_of?(::Regexer::Models::Pattern)
    end

    alias word_character has_word_character
    alias letter has_letter
    alias number has_number
    alias ascii_character has_ascii_character
    alias consecutive has_consecutive
    alias none_or_consecutive has_none_or_consecutive
    alias group has_group
    alias any_character_in has_any_character_in
  end
end
