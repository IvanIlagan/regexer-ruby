# frozen_string_literal: true

require "regexer"
require "pry"

RSpec.describe "Regexer::Pattern #has_none_or_consecutive" do
  let(:pattern_block) do
    -> { has_none_or_consecutive nil }
  end

  subject(:pattern) do
    Regexer::PatternBuilder.new(&pattern_block).result.regex
  end

  context "when none_or_consecutive alias method is used" do
    let!(:pattern_block) do
      -> { none_or_consecutive "test" }
    end

    it "returns /(test)*/ regex pattern" do
      expect(pattern).to eq(/(test)*/)
    end
  end

  context "when value is only a string 'test'" do
    let!(:pattern_block) do
      -> { has_none_or_consecutive "test" }
    end

    it "returns /(test)*/ regex pattern" do
      expect(pattern).to eq(/(test)*/)
    end
  end

  context "when value is only a number" do
    context "when the number is an int 12345" do
      let!(:pattern_block) do
        -> { has_none_or_consecutive 12_345 }
      end

      it "returns /(12345)*/ regex pattern" do
        expect(pattern).to eq(/(12345)*/)
      end
    end

    context "when the number is a float 56.23" do
      let!(:pattern_block) do
        -> { has_none_or_consecutive 56.23 }
      end

      it "returns /(56\.23)*/ regex pattern" do
        expect(pattern).to eq(/(56\.23)*/)
      end
    end
  end

  context "when single entity values are given" do
    context "when value given is a single character" do
      let!(:pattern_block) do
        -> { has_none_or_consecutive "@" }
      end

      it "does not wrap the character in parentheses" do
        expect(pattern).to eq(/@*/)
      end
    end
  end

  context "when non-single entity values are given" do
    context "when value is a non-single entity pattern object" do
      let(:pattern_block) do
        -> { has_none_or_consecutive starts_with letter from: "A", to: "z" }
      end

      it "wraps the pattern in parentheses" do
        expect(pattern).to eq(/(^[A-z])*/)
      end
    end
  end

  context "when value is a DSL methods" do
    context "when value is 1 DSL methods: number" do
      let!(:pattern_block) do
        -> { has_none_or_consecutive number from: 0, to: 9 }
      end

      it "returns /[0-9]*/ regex pattern" do
        expect(pattern).to eq(/[0-9]*/)
      end
    end

    context "when value is 2 DSL methods chained together: contains letter" do
      let!(:pattern_block) do
        -> { has_none_or_consecutive contains letter from: "A", to: "z" }
      end

      it "returns /[A-z]*/ regex pattern" do
        expect(pattern).to eq(/[A-z]*/)
      end
    end
  end

  context "when value is NOT a string or an integer or a float or a Regexer::Models::Pattern" do
    let!(:pattern_block) do
      -> { has_none_or_consecutive(/(test)/) }
    end

    it "raises InvalidValueError error with message 'Value should only be of type String or Integer or Float or Regexer::Models::Pattern'" do
      expect { pattern }.to raise_error(Regexer::Exceptions::InvalidValueError)
        .with_message("Value should only be of type String or Integer or Float or Regexer::Models::Pattern")
    end
  end
end
