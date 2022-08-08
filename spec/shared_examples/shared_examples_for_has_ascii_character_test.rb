# frozen_string_literal: true

RSpec.shared_examples "has_ascii_character method test example" do |from_value:, to_value:, expected_value:|
  context "when creating a regex pattern for matching an ascii character in a range #{from_value} - #{to_value}" do
    let!(:value1) { from_value }
    let!(:value2) { to_value }

    it "returns #{expected_value.inspect} regex pattern" do
      expect(pattern).to eq(expected_value)
    end

    context "when ascii_character alias method is used" do
      let!(:pattern_block) do
        lambda do |val1, val2|
          -> { ascii_character from: val1, to: val2 }
        end.call(value1, value2)
      end

      it "returns #{expected_value.inspect} regex pattern" do
        expect(pattern).to eq(expected_value)
      end
    end
  end
end

RSpec.shared_examples "has_ascii_character method invalid From-To Value Range Error" do |from_value:, to_value:|
  context "when From value is greater than the To value in terms of ASCII value" do
    let!(:value1) { from_value }
    let!(:value2) { to_value }

    it "raises a RangeError error" do
      expect do
        pattern
      end.to raise_error(RangeError)
    end
  end
end

RSpec.shared_examples "has_ascii_character method invalid From-To Value Error" do |from_value:, to_value:|
  context "when From value or To value is NOT a single ascii character" do
    let!(:value1) { from_value }
    let!(:value2) { to_value }

    it "raises InvalidValueError error with 'Value should only be a single character in the ascii table' as error message" do
      expect do
        pattern
      end.to raise_error(Regexer::Exceptions::InvalidValueError)
        .with_message("Value should only be a single character in the ascii table")
    end
  end
end
