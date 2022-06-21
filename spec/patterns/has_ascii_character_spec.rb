# frozen_string_literal: true

require "regexer"
require "./spec/shared_examples/shared_examples_for_has_ascii_character_test"
require "pry"

RSpec.describe "Regexer::Pattern #has_ascii_character" do
  let(:value1) { nil }
  let(:value2) { nil }

  let(:pattern_block) do
    lambda do |val1, val2|
      -> { has_ascii_character from: val1, to: val2 }
    end.call(value1, value2)
  end

  subject(:pattern) do
    Regexer::PatternBuilder.new(&pattern_block).result.regex
  end

  include_examples "has_ascii_character method test example", from_value: "A", to_value: "z", expected_value: /[A-z]/
  include_examples "has_ascii_character method test example", from_value: "<", to_value: "}", expected_value: /[<-\}]/
  include_examples "has_ascii_character method invalid From-To Value Range Error", from_value: "a", to_value: "Z"
  include_examples "has_ascii_character method invalid From-To Value Range Error", from_value: "~", to_value: "!"
  include_examples "has_ascii_character method invalid From-To Value Error", from_value: "test", to_value: 239
  include_examples "has_ascii_character method invalid From-To Value Error", from_value: "t", to_value: "的"
end
