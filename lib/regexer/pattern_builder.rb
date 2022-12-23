require "regexer/validators/from_to_validator"
require "regexer/validators/contains_value_validator"
require "regexer/validators/any_character_in_validator"
require "regexer/exceptions/no_block_given_error"
require "regexer/models/pattern"
require "regexer/models/character_range_pattern"
require "regexer/utils/single_entity_checker"
require "regexer/utils/quantifier_value_generator"
require "regexer/utils/pattern_sanitizer"
require "regexer/utils/string_helper"
require "regexer/utils/any_character_in_value_transformer"
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

    # STRUCTS
    ConsecutiveOptions = Struct.new(:exactly, :minimum, :maximum)

    # SPECIAL FUNCTION CHARACTERS
    # MOSTLY IMPLEMENTATION OF SPECIAL CHARACTERS IN REGEX
    def starts_with(value)
      pattern = contains(value)&.raw_pattern

      pattern_object = Regexer::Models::Pattern.new(String.new(pattern).insert(0, "^"), single_entity: false)
      Regexer::Utils::StringHelper.update_string_pattern(@final_pattern, pattern, pattern_object.raw_pattern)
      pattern_object
    end

    def ends_with(value)
      pattern = contains(value)&.raw_pattern

      pattern_object = Regexer::Models::Pattern.new(String.new(pattern).insert(-1, "$"), single_entity: false)
      Regexer::Utils::StringHelper.update_string_pattern(@final_pattern, pattern, pattern_object.raw_pattern)
      pattern_object
    end

    # REGEX QUANTIFIERS
    def has_consecutive_instances_of(value, exactly: nil, minimum: nil, maximum: nil)
      pattern = contains(value)&.raw_pattern

      quantifier_pattern = Regexer::Utils::QuantifierValueGenerator
                           .generate(ConsecutiveOptions.new(exactly, minimum, maximum))
      pattern_object = Regexer::Models::Pattern.new(
        String.new(pattern).insert(-1, quantifier_pattern),
        single_entity: false
      )

      Regexer::Utils::StringHelper.update_string_pattern(@final_pattern, pattern, pattern_object.raw_pattern)
      pattern_object
    end

    def has_none_or_consecutive_instances_of(value)
      pattern = contains(value)&.raw_pattern

      pattern_object = Regexer::Models::Pattern.new(String.new(pattern).insert(-1, "*"), single_entity: false)
      Regexer::Utils::StringHelper.update_string_pattern(@final_pattern, pattern, pattern_object.raw_pattern)
      pattern_object
    end

    def has_none_or_one_instance_of(value)
      pattern = contains(value)&.raw_pattern

      pattern_object = Regexer::Models::Pattern.new(String.new(pattern).insert(-1, "?"), single_entity: false)
      Regexer::Utils::StringHelper.update_string_pattern(@final_pattern, pattern, pattern_object.raw_pattern)
      pattern_object
    end

    # BASIC EASE OF USE PATTERNS
    def has_letter(from:, to:)
      Regexer::Validators::FromToValidator.valid_values?("letter", from, to)
      pattern_object = Regexer::Models::Pattern.new("[#{from}-#{to}]")
      @final_pattern += pattern_object.raw_pattern
      pattern_object
    end

    def has_number(from:, to:)
      Regexer::Validators::FromToValidator.valid_values?("number", from, to)
      pattern_object = Regexer::Models::Pattern.new("[#{from}-#{to}]")
      @final_pattern += pattern_object.raw_pattern
      pattern_object
    end

    def has_ascii_character(from:, to:)
      Regexer::Validators::FromToValidator.valid_values?("ascii_character", from, to)
      pattern_object = Regexer::Models::Pattern.new("[#{Regexp.escape(from)}-#{Regexp.escape(to)}]")
      @final_pattern += pattern_object.raw_pattern
      pattern_object
    end

    def _or_
      pattern_object = Regexer::Models::Pattern.new("\|")
      @final_pattern += pattern_object.raw_pattern
      pattern_object
    end

    def has_alphanumeric_character
      pattern_object = Regexer::Models::Pattern.new("[A-Za-z0-9]")
      @final_pattern += pattern_object.raw_pattern
      pattern_object
    end

    def has_any_character_except_new_line
      pattern_object = Regexer::Models::Pattern.new(".")
      @final_pattern += pattern_object.raw_pattern
      pattern_object
    end

    def contains(value)
      Regexer::Validators::ContainsValueValidator.value_valid?(value)

      sanitized_pattern = Regexer::Utils::PatternSanitizer.sanitize(value)

      pattern_object = if ::Regexer::Utils::SingleEntityChecker.single_entity?(value)
                         Regexer::Models::Pattern.new(sanitized_pattern)
                       else
                         Regexer::Models::Pattern.new("(#{sanitized_pattern})")
                       end

      Regexer::Utils::StringHelper.update_string_pattern(
        @final_pattern,
        value.instance_of?(::Regexer::Models::Pattern) ? sanitized_pattern : "",
        pattern_object.raw_pattern
      )
      pattern_object
    end

    def has_group(&block)
      raise Regexer::Exceptions::NoBlockGivenError unless block_given?

      value = Regexer::PatternBuilder.new(&block).result
      sanitized_pattern = Regexer::Utils::PatternSanitizer.sanitize(value)
      pattern_object = Regexer::Models::Pattern.new("(#{sanitized_pattern})")
      Regexer::Utils::StringHelper.update_string_pattern(@final_pattern, sanitized_pattern, pattern_object.raw_pattern)
      pattern_object
    end

    def has_any_character_in(*values)
      combined_pattern = values.reduce("") do |pattern, value|
        Regexer::Validators::AnyCharacterInValidator.value_valid?(value)
        pattern + Regexer::Utils::AnyCharacterInValueTransformer.transform(value)
      end

      pattern_object = Regexer::Models::Pattern.new("[#{combined_pattern}]")
      @final_pattern += pattern_object.raw_pattern
      pattern_object
    end

    def has_any_character_not_in(*values)
      pattern = has_any_character_in(*values)&.raw_pattern

      pattern_object = Regexer::Models::Pattern.new(String.new(pattern).insert(1, "^"), single_entity: true)
      Regexer::Utils::StringHelper.update_string_pattern(@final_pattern, pattern, pattern_object.raw_pattern)
    end

    # Shorthand characters
    def has_whitespace_character
      pattern_object = Regexer::Models::Pattern.new("\\s")
      @final_pattern += pattern_object.raw_pattern
      pattern_object
    end

    def has_non_whitespace_character
      pattern_object = Regexer::Models::Pattern.new("\\S")
      @final_pattern += pattern_object.raw_pattern
      pattern_object
    end

    def has_digit_character
      pattern_object = Regexer::Models::Pattern.new("\\d")
      @final_pattern += pattern_object.raw_pattern
      pattern_object
    end

    def has_word_character
      pattern_object = Regexer::Models::Pattern.new("\\w")
      @final_pattern += pattern_object.raw_pattern
      pattern_object
    end

    def has_non_digit_character
      pattern_object = Regexer::Models::Pattern.new("\\D")
      @final_pattern += pattern_object.raw_pattern
      pattern_object
    end

    def has_newline_character
      pattern_object = Regexer::Models::Pattern.new("\\n")
      @final_pattern += pattern_object.raw_pattern
      pattern_object
    end

    def has_tab_character
      pattern_object = Regexer::Models::Pattern.new("\\t")
      @final_pattern += pattern_object.raw_pattern
      pattern_object
    end

    def has_non_word_character
      pattern_object = Regexer::Models::Pattern.new("\\W")
      @final_pattern += pattern_object.raw_pattern
      pattern_object
    end

    def contains_a_word_ending_with(value)
      pattern = contains(value)&.raw_pattern
      pattern_object = Regexer::Models::Pattern.new("#{pattern}\\b", single_entity: false)
      Regexer::Utils::StringHelper.update_string_pattern(@final_pattern, pattern, pattern_object.raw_pattern)
      pattern_object
    end

    def contains_a_word_starting_with(value)
      pattern = contains(value)&.raw_pattern
      pattern_object = Regexer::Models::Pattern.new("\\b#{pattern}", single_entity: false)
      Regexer::Utils::StringHelper.update_string_pattern(@final_pattern, pattern, pattern_object.raw_pattern)
      pattern_object
    end

    def contains_the_word(value)
      pattern = contains(value)&.raw_pattern
      pattern_object = Regexer::Models::Pattern.new("\\b#{pattern}\\b", single_entity: false)
      Regexer::Utils::StringHelper.update_string_pattern(@final_pattern, pattern, pattern_object.raw_pattern)
      pattern_object
    end

    # VALUE BUILDER METHOD THAT IS COMPATIBILE WITH THE PATTERN BUILDER
    def character_range(from:, to:)
      Regexer::Validators::FromToValidator.valid_values?("ascii_character", from, to)
      Regexer::Models::CharacterRangePattern.new(from, to)
    end

    alias alphanumeric_character has_alphanumeric_character
    alias any_character_except_new_line has_any_character_except_new_line
    alias letter has_letter
    alias number has_number
    alias ascii_character has_ascii_character
    alias consecutive_instances_of has_consecutive_instances_of
    alias none_or_consecutive_instances_of has_none_or_consecutive_instances_of
    alias none_or_one_instance_of has_none_or_one_instance_of
    alias group has_group
    alias any_character_in has_any_character_in
    alias any_character_not_in has_any_character_not_in

    # Shorthand character alias methods
    alias word_character has_word_character
    alias non_word_character has_non_word_character
    alias whitespace_character has_whitespace_character
    alias non_whitespace_character has_non_whitespace_character
    alias digit_character has_digit_character
    alias non_digit_character has_non_digit_character
    alias newline_character has_newline_character
    alias tab_character has_tab_character
    alias the_word contains_the_word
    alias contains_the_word_with contains_the_word
    alias the_word_with contains_the_word
    alias a_word_starting_with contains_a_word_starting_with
    alias a_word_ending_with contains_a_word_ending_with
  end
end
