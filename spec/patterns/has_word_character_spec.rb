# frozen_string_literal: true

require "regexer"
require "./spec/shared_examples/shared_examples_for_has_word_character_test"

RSpec.describe "Regexer::Pattern #contains" do
  let(:pattern_block) do
    -> { has_word_character }
  end

  subject(:pattern) do
    Regexer::Pattern.new(&pattern_block).build_regex
  end

  include_examples "has_word_character method test examples", [
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
    }
  ]
end
