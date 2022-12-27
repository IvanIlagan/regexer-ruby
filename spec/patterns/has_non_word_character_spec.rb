# frozen_string_literal: true

require "regexer"
require "./spec/shared_examples/shared_examples_for_shorthand_character_test"

RSpec.describe "Regexer::Pattern #has_non_word_character" do
  let(:pattern_block) do
    -> { has_non_word_character }
  end

  subject(:pattern) do
    Regexer::PatternBuilder.new(&pattern_block).result.regex
  end

  context "when method is called" do
    it "returns a Regexer::Models::Pattern object" do
      expect(Regexer::PatternBuilder.new(&pattern_block).send(:has_non_word_character)).to be_a Regexer::Models::Pattern
    end
  end

  include_examples "shorthand character method test examples", "\\W", [
    {
      case: "when has_non_word_character is used",
      expected_value: /\W/
    },
    {
      case: "when string being matched is 'testing'",
      fail_value: "testing"
    },
    {
      case: "when string being matched is '12345'",
      fail_value: "12345"
    },
    {
      case: "when string being matched is 'test!_123@yahoo.com'",
      test_value: "test!_123@yahoo.com"
    },
    {
      case: "when string being matched is '^&@'",
      test_value: "^&@"
    }
  ]

  context "when non_word_character alias method is used" do
    let!(:pattern_block) do
      -> { non_word_character }
    end

    it "returns /\\W/ regex pattern" do
      expect(pattern).to eq(/\W/)
    end
  end
end
