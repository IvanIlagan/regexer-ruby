# frozen_string_literal: true

require "regexer"
require "./spec/shared_examples/shared_examples_for_shorthand_character_test"

RSpec.describe "Regexer::Pattern #has_tab_character" do
  let(:pattern_block) do
    -> { has_tab_character }
  end

  subject(:pattern) do
    Regexer::PatternBuilder.new(&pattern_block).result.regex
  end

  include_examples "shorthand character method test examples", "\\t", [
    {
      case: "when has_tab_character is used",
      expected_value: /\t/
    },
    {
      case: "when string being matched is '\\t'",
      test_value: "\t"
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

  context "when tab_character alias method is used" do
    let!(:pattern_block) do
      -> { tab_character }
    end

    it "returns /\\t/ regex pattern" do
      expect(pattern).to eq(/\t/)
    end
  end
end