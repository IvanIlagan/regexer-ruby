# frozen_string_literal: true

require "regexer"
require "./spec/shared_examples/shared_examples_for_contains_test"

RSpec.describe "Regexer::Pattern #starts_with" do
  let(:val) { nil }

  let(:pattern_block) do
    lambda do |value|
      -> { starts_with value }
    end.call(val)
  end

  subject(:pattern) do
    Regexer::PatternBuilder.new(&pattern_block).result.regex
  end

  context "when method is called" do
    let!(:val) { "test" }

    it "returns a Regexer::Models::Pattern object" do
      expect(Regexer::PatternBuilder.new(&pattern_block).send(:starts_with, "test")).to be_a Regexer::Models::Pattern
    end
  end

  # NOTE: Under the hood, starts_with method actually uses the contains method
  include_examples "contains method test examples", [
    {
      case: "when value is an exact integer: 26543",
      test_value: 26_543,
      expected_value: /^(26543)/
    },
    {
      case: "when value is an exact float: 3.56",
      test_value: 3.56,
      expected_value: /^(3\.56)/
    },
    {
      case: "when value is an exact set of characters: 'testing'",
      test_value: "testing",
      expected_value: /^(testing)/
    },
    {
      case: "when value contains regex special characters",
      test_value: ".+*?^$()[]{}|\\",
      custom_assertion_message: "escapes those special characters in the final generated pattern",
      expected_value: /^(\.\+\*\?\^\$\(\)\[\]\{\}\|\\)/
    }
  ]

  context "when single entity values are given" do
    include_examples "contains method test examples", [
      {
        case: "when value given is a single character",
        test_value: "@",
        custom_assertion_message: "does not wrap the character in parentheses",
        expected_value: /^@/
      }
    ]
  end

  context "when non-single entity values are given" do
    context "when value is a non-single entity pattern object" do
      let(:pattern_block) do
        -> { starts_with consecutive_instances_of letter from: "A", to: "z" }
      end

      it "wraps the pattern in parentheses" do
        expect(pattern).to eq(/^([A-z]+)/)
      end
    end
  end

  context "when method is used to chain another method" do
    let(:pattern_block) do
      -> { starts_with word_character }
    end

    it "successfully replaced the first generated pattern in the chain" do
      expect(pattern).to eq(/^\w/)
    end
  end

  include_examples "contains method invalid value error test example", value: /test/
end
