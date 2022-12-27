# frozen_string_literal: true

require "regexer"
require "./spec/shared_examples/shared_examples_for_has_letter_test"
require "pry"

RSpec.describe "Regexer::Pattern #has_letter" do
  let(:value1) { nil }
  let(:value2) { nil }

  let(:pattern_block) do
    lambda do |val1, val2|
      -> { has_letter from: val1, to: val2 }
    end.call(value1, value2)
  end

  subject(:pattern) do
    Regexer::PatternBuilder.new(&pattern_block).result.regex
  end

  context "when method is called" do
    let!(:value1) { "a" }
    let!(:value2) { "z" }

    it "returns a Regexer::Models::Pattern object" do
      expect(Regexer::PatternBuilder.new(&pattern_block).send(:has_letter, from: "a", to: "z")).to be_a Regexer::Models::Pattern
    end
  end

  include_examples "has_letters method test example", from_value: "A", to_value: "z", expected_value: /[A-z]/
  include_examples "has_letters method invalid From-To Value Range Error", from_value: "a", to_value: "Z"
  include_examples "has_letters method invalid From-To Value Error", from_value: "test", to_value: 239
end
