# frozen_string_literal: true

require "regexer"
require "regexer/exceptions/invalid_from_to_range_error"
require "./spec/shared_examples/shared_examples_for_has_letters_test"
require "pry"

RSpec.describe "Regexer::Pattern #has_none_or_more_letters" do
  let(:value1) { nil }
  let(:value2) { nil }

  let(:pattern_block) do
    lambda do |val1, val2|
      -> { has_none_or_more_letters from: val1, to: val2 }
    end.call(value1, value2)
  end

  subject(:pattern) do
    Regexer::Pattern.new(&pattern_block).build_regex
  end

  include_examples "has_letters method test example", from_value: "A", to_value: "z", expected_value: /[A-z]*/
  include_examples "has_letters method invalid From-To Value Range Error", from_value: "z", to_value: "A"
  include_examples "has_letters method invalid From-To Value Error", from_value: "test", to_value: 239
end
