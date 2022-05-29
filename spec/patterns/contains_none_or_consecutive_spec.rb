# frozen_string_literal: true

require "regexer"
require "./spec/shared_examples/shared_examples_for_contains_test"

RSpec.describe "Regexer::Pattern #contains_none_or_consecutive" do
  let(:val) { nil }

  let(:pattern_block) do
    lambda do |value|
      -> { contains_none_or_consecutive value }
    end.call(val)
  end

  subject(:pattern) do
    Regexer::Pattern.new(&pattern_block).build_regex
  end

  include_examples "contains method test examples", [
    {
      case: "when value is an exact integer: 26543",
      test_value: 26_543,
      expected_value: /(26543)*/
    },
    {
      case: "when value is an exact float: 3.56",
      test_value: 3.56,
      expected_value: /(3\.56)*/
    },
    {
      case: "when value is an exact set of characters: 'testing'",
      test_value: "testing",
      expected_value: /(testing)*/
    },
    {
      case: "when value contains regex special characters",
      test_value: ".+*?^$()[]{}|\\",
      custom_assertion_message: "escapes those special characters in the final generated pattern",
      expected_value: /(\.\+\*\?\^\$\(\)\[\]\{\}\|\\)*/
    }
  ]
  include_examples "contains method invalid value error test example", value: /test/
end
