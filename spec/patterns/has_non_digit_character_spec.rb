# frozen_string_literal: true

require "regexer"
require "./spec/shared_examples/shared_examples_for_shorthand_character_test"

RSpec.describe "Regexer::Pattern #has_non_digit_character" do
  let(:pattern_block) do
    -> { has_non_digit_character }
  end

  subject(:pattern) do
    Regexer::PatternBuilder.new(&pattern_block).result.regex
  end

  include_examples "shorthand character method test examples", "\\D", [
    {
      case: "when has_non_digit_character is used",
      expected_value: /\D/
    },
    {
      case: "when string being matched is 'a'",
      test_value: "a"
    },
    {
      case: "when string being matched is '&'",
      test_value: "&"
    },
    {
      case: "when string being matched is '0'",
      fail_value: "0"
    }
  ]

  context "when non_digit_character alias method is used" do
    let!(:pattern_block) do
      -> { non_digit_character }
    end

    it "returns /\\D/ regex pattern" do
      expect(pattern).to eq(/\D/)
    end
  end
end
