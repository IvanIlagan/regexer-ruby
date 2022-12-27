# frozen_string_literal: true

require "regexer"
require "./spec/shared_examples/shared_examples_for_shorthand_character_test"

RSpec.describe "Regexer::Pattern #has_newline_character" do
  let(:pattern_block) do
    -> { has_newline_character }
  end

  subject(:pattern) do
    Regexer::PatternBuilder.new(&pattern_block).result.regex
  end

  context "when method is called" do
    it "returns a Regexer::Models::Pattern object" do
      expect(Regexer::PatternBuilder.new(&pattern_block).send(:has_newline_character)).to be_a Regexer::Models::Pattern
    end
  end

  include_examples "shorthand character method test examples", "\\n", [
    {
      case: "when has_newline_character is used",
      expected_value: /\n/
    },
    {
      case: "when string being matched is '\\n'",
      test_value: "\n"
    },
    {
      case: "when string being matched is '&'",
      fail_value: "&"
    },
    {
      case: "when string being matched is '0'",
      fail_value: "0"
    },
    {
      case: "when string being matched is 't'",
      fail_value: "t"
    }
  ]

  context "when newline_character alias method is used" do
    let!(:pattern_block) do
      -> { newline_character }
    end

    it "returns /\\n/ regex pattern" do
      expect(pattern).to eq(/\n/)
    end
  end
end
