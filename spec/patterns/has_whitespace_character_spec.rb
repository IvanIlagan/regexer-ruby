# frozen_string_literal: true

require "regexer"
require "./spec/shared_examples/shared_examples_for_shorthand_character_test"

RSpec.describe "Regexer::Pattern #has_whitespace_character" do
  let(:pattern_block) do
    -> { has_whitespace_character }
  end

  subject(:pattern) do
    Regexer::PatternBuilder.new(&pattern_block).result.regex
  end

  context "when method is called" do
    it "returns a Regexer::Models::Pattern object" do
      expect(Regexer::PatternBuilder.new(&pattern_block).send(:has_whitespace_character)).to be_a Regexer::Models::Pattern
    end
  end

  include_examples "shorthand character method test examples", "\\s", [
    {
      case: "when has_whitespace_character is used",
      expected_value: /\s/
    },
    {
      case: "when string being matched is '\\t'",
      test_value: "\t"
    },
    {
      case: "when string being matched is space",
      test_value: " "
    },
    {
      case: "when string being matched is '\\n'",
      test_value: "\n"
    },
    {
      case: "when string being matched is '12345'",
      fail_value: "12345"
    }
  ]

  context "when whitespace_character alias method is used" do
    let!(:pattern_block) do
      -> { whitespace_character }
    end

    it "returns /\\s/ regex pattern" do
      expect(pattern).to eq(/\s/)
    end
  end
end
