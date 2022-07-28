# frozen_string_literal: true

require "regexer"
require "./spec/shared_examples/shared_examples_for_has_ascii_character_test"

RSpec.describe "Regexer::Pattern #character_range" do
  let(:value1) { nil }
  let(:value2) { nil }

  let(:pattern_block) do
    -> { "test" }
  end

  subject(:pattern) do
    Regexer::PatternBuilder.new(&pattern_block).send(:character_range, from: value1, to: value2)
  end

  include_examples "has_ascii_character method test example", from_value: "A", to_value: "z", expected_value: { from: "A", to: "z" }
  include_examples "has_ascii_character method test example", from_value: "<", to_value: "}", expected_value: { from: "<", to: "\\}" }
  include_examples "has_ascii_character method invalid From-To Value Range Error", from_value: "a", to_value: "Z"
  include_examples "has_ascii_character method invalid From-To Value Range Error", from_value: "~", to_value: "!"
  include_examples "has_ascii_character method invalid From-To Value Error", from_value: "test", to_value: 239
  include_examples "has_ascii_character method invalid From-To Value Error", from_value: "t", to_value: "的"
end
