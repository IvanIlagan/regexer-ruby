# frozen_string_literal: true

require "regexer"
require "regexer/exceptions/invalid_from_to_range_error"

RSpec.describe "Regexer::Pattern #has_consecutive_letters" do
  context "when creating a regex pattern for matching consecutive letters in a range A-z" do
    it "returns /[A-z]+/ regex pattern" do
      pattern = Regexer::Pattern.new do
        has_consecutive_letters from: "A", to: "z"
      end

      expect(pattern.build_regex).to eq(/[A-z]+/)
    end

    context "when From value is greater than the To value in terms of ASCII value" do
      it "raises a InvalidFromToRangeError error" do
        expect do
          Regexer::Pattern.new do
            has_consecutive_letters from: "a", to: "Z"
          end.build_regex
        end.to raise_error(Regexer::Exceptions::InvalidFromToRangeError)
      end
    end

    context "when From value or To value is NOT a single letter" do
      it "raises InvalidValueError error with 'Value should only be a single letter' as error message" do
        expect do
          Regexer::Pattern.new do
            has_consecutive_letters from: "test", to: 239
          end.build_regex
        end.to raise_error(Regexer::Exceptions::InvalidValueError)
          .with_message("Value should only be a single letter")
      end
    end
  end
end
