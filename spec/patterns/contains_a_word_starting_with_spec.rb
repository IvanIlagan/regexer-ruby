# frozen_string_literal: true

require "regexer"
require "./spec/shared_examples/shared_examples_for_contains_test"

RSpec.describe "Regexer::Pattern #contains_a_word_starting_with" do
  let(:val) { nil }

  let(:pattern_block) do
    lambda do |value|
      -> { contains_a_word_starting_with value }
    end.call(val)
  end

  subject(:pattern) do
    Regexer::PatternBuilder.new(&pattern_block).result.regex
  end

  # NOTE: Under the hood, contains_a_word_starting_with method actually uses the contains method
  include_examples "contains method test examples", [
    {
      case: "when value is an exact integer: 26543",
      test_value: 26_543,
      expected_value: /\b(26543)/
    },
    {
      case: "when value is an exact float: 3.56",
      test_value: 3.56,
      expected_value: /\b(3\.56)/
    },
    {
      case: "when value is an exact set of characters: 'testing'",
      test_value: "testing",
      expected_value: /\b(testing)/
    },
    {
      case: "when value contains regex special characters",
      test_value: ".+*?^$()[]{}|\\",
      custom_assertion_message: "escapes those special characters in the final generated pattern",
      expected_value: /\b(\.\+\*\?\^\$\(\)\[\]\{\}\|\\)/
    }
  ]

  context "when the_word_starting_with alias method is used" do
    let!(:pattern_block) do
      -> { a_word_starting_with "a" }
    end

    it "returns /\\ba/ regex pattern" do
      expect(pattern).to eq(/\ba/)
    end
  end

  context "when single entity values are given" do
    include_examples "contains method test examples", [
      {
        case: "when value given is a single character",
        test_value: "@",
        custom_assertion_message: "does not wrap the character in parentheses",
        expected_value: /\b@/
      }
    ]
  end

  context "when non-single entity values are given" do
    context "when value is a non-single entity pattern object" do
      let(:pattern_block) do
        -> { contains_a_word_starting_with consecutive_instances_of letter from: "A", to: "z" }
      end

      it "wraps the pattern in parentheses" do
        expect(pattern).to eq(/\b([A-z]+)/)
      end
    end
  end

  include_examples "contains method invalid value error test example", value: /test/
end
