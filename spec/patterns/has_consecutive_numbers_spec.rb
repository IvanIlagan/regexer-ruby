# frozen_string_literal: true

require "regexer"
require "regexer/exceptions/invalid_from_to_range_error"

RSpec.describe "Regexer::Pattern #has_consecutive_numbers" do
  context "when creating a regex pattern for matching consecutive numbers in a range 0-9" do
    it "returns /[0-9]+/ regex pattern" do
      pattern = Regexer::Pattern.new do
        has_consecutive_numbers from: 0, to: 9
      end.build_regex

      expect(pattern).to eq(/[0-9]+/)
    end

    context "when From value is greater than the To value" do
      it "raises InvalidFromToRangeError error" do
        expect do
          Regexer::Pattern.new do
            has_consecutive_numbers from: 9, to: 0
          end.build_regex
        end.to raise_error(Regexer::Exceptions::InvalidFromToRangeError)
      end
    end

    context "when From value or To value is NOT an integer from 0 to 9" do
      it "raises InvalidValueError error with 'Value should only be an integer from 0 to 9' as error message" do
        expect do
          Regexer::Pattern.new do
            has_consecutive_numbers from: -2, to: 92
          end.build_regex
        end.to raise_error(Regexer::Exceptions::InvalidValueError)
          .with_message("Value should only be an integer from 0 to 9")
      end
    end
  end
end
