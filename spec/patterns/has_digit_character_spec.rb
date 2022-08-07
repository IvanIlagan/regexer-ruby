# frozen_string_literal: true

require "regexer"
require "./spec/shared_examples/shared_examples_for_shorthand_character_test"

RSpec.describe "Regexer::Pattern #has_digit_character" do
  let(:pattern_block) do
    -> { has_digit_character }
  end

  subject(:pattern) do
    Regexer::PatternBuilder.new(&pattern_block).result.regex
  end

  include_examples "shorthand character method test examples", "\\d", [
    {
      case: "when has_digit_character is used",
      expected_value: /\d/
    },
    {
      case: "when string being matched is '2'",
      test_value: "2"
    },
    {
      case: "when string being matched is '9'",
      test_value: "9"
    },
    {
      case: "when string being matched is 'a'",
      fail_value: "a"
    }
  ]

  context "when digit_character alias method is used" do
    let!(:pattern_block) do
      -> { digit_character }
    end

    it "returns /\\d/ regex pattern" do
      expect(pattern).to eq(/\d/)
    end
  end
end
