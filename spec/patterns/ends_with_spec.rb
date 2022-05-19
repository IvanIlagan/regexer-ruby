# frozen_string_literal: true

require "regexer"
require "regexer/exceptions/invalid_from_to_range_error"

RSpec.describe "Regexer::Pattern #ends_with" do
  context "when creating a regex pattern for matching a set of given characters in the end of strings" do
    context "when value is an exact integer: 26543" do
      it "returns /(26543)$/ regex pattern" do
        pattern = Regexer::Pattern.new do
          ends_with 26_543
        end.build_regex

        expect(pattern).to eq(/(26543)$/)
      end
    end

    context "when value is an exact float: 3.56" do
      it "returns /(3\.56)$/ regex pattern" do
        pattern = Regexer::Pattern.new do
          ends_with 3.56
        end.build_regex

        expect(pattern).to eq(/(3\.56)$/)
      end
    end

    context "when value is an exact set of characters: 'testing'" do
      it "returns /(testing)$/ regex pattern" do
        pattern = Regexer::Pattern.new do
          ends_with "testing"
        end.build_regex

        expect(pattern).to eq(/(testing)$/)
      end
    end

    context "when value contains regex special characters" do
      it "escapes those special characters in the final generated pattern" do
        pattern = Regexer::Pattern.new do
          ends_with ".+*?^$()[]{}|\\"
        end.build_regex

        expect(pattern).to eq(/(\.\+\*\?\^\$\(\)\[\]\{\}\|\\)$/)
      end
    end

    context "when value is NOT a string or an integer or a float" do
      it "raises InvalidValueError error" do
        expect do
          Regexer::Pattern.new do
            ends_with(/test/)
          end.build_regex
        end.to raise_error(Regexer::Exceptions::InvalidValueError)
          .with_message("Value should only be of type String or Integer or Float")
      end
    end
  end
end