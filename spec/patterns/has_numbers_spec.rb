# frozen_string_literal: true

require "regexer"
require "./spec/shared_examples/shared_examples_for_has_numbers_test"

RSpec.describe "Regexer::Pattern #has_numbers" do
  let(:value1) { nil }
  let(:value2) { nil }

  let(:pattern_block) do
    lambda do |val1, val2|
      -> { has_numbers from: val1, to: val2 }
    end.call(value1, value2)
  end

  subject(:pattern) do
    Regexer::Pattern.new(&pattern_block).build_regex
  end

  include_examples "has_numbers method test example", from_value: 0, to_value: 9, expected_value: /[0-9]/
  include_examples "has_numbers method invalid From-To Value Range Error", from_value: 9, to_value: 0
  include_examples "has_numbers method invalid From-To Value Error", from_value: -2, to_value: 92
end
