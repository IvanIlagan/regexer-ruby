# frozen_string_literal: true

require "regexer"
require "./spec/shared_examples/shared_examples_for_shorthand_character_test"

RSpec.describe "Regexer::Pattern #has_non_whitespace_character" do
  let(:pattern_block) do
    -> { has_non_whitespace_character }
  end

  subject(:pattern) do
    Regexer::PatternBuilder.new(&pattern_block).result.regex
  end

  context "when method is called" do
    it "returns a Regexer::Models::Pattern object" do
      expect(Regexer::PatternBuilder.new(&pattern_block).send(:has_non_whitespace_character)).to be_a Regexer::Models::Pattern
    end
  end

  include_examples "shorthand character method test examples", "\\S", [
    {
      case: "when has_non_whitespace_character is used",
      expected_value: /\S/
    },
    {
      case: "when string being matched is '123'",
      test_value: "123"
    },
    {
      case: "when string being matched is 'test'",
      test_value: "test"
    },
    {
      case: "when string being matched is '\\n'",
      fail_value: "\n"
    }
  ]

  context "when non_whitespace_character alias method is used" do
    let!(:pattern_block) do
      -> { non_whitespace_character }
    end

    it "returns /\\s/ regex pattern" do
      expect(pattern).to eq(/\S/)
    end
  end
end
