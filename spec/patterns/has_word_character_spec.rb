# frozen_string_literal: true

require "regexer"
require "./spec/shared_examples/shared_examples_for_shorthand_character_test"

RSpec.describe "Regexer::Pattern #has_word_character" do
  let(:pattern_block) do
    -> { has_word_character }
  end

  subject(:pattern) do
    Regexer::PatternBuilder.new(&pattern_block).result.regex
  end

  include_examples "shorthand character method test examples", "\\w", [
    {
      case: "when has_word_character is used",
      expected_value: /\w/
    },
    {
      case: "when string being matched is 'testing'",
      test_value: "testing"
    },
    {
      case: "when string being matched is '12345'",
      test_value: "12345"
    },
    {
      case: "when string being matched is 'test!_123@yahoo.com'",
      test_value: "test!_123@yahoo.com"
    },
    {
      case: "when string being matched is '^&@'",
      fail_value: "^&@"
    }
  ]

  context "when word_character alias method is used" do
    let!(:pattern_block) do
      -> { word_character }
    end

    it "returns /\\w/ regex pattern" do
      expect(pattern).to eq(/\w/)
    end
  end
end
