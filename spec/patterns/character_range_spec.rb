# frozen_string_literal: true

require "regexer"

RSpec.describe "Regexer::Pattern #character_range" do
  let(:value1) { nil }
  let(:value2) { nil }

  let(:pattern_block) do
    -> { "test" }
  end

  subject(:return_value) do
    Regexer::PatternBuilder.new(&pattern_block).send(:character_range, from: value1, to: value2)
  end

  context "when #character_range value builder method is used" do
    context "when From value is 'A' and To value is 'z'" do
      let!(:value1) { "A" }
      let!(:value2) { "z" }

      it "returns { from: 'A', to: 'z' } hash with regex escaped values" do
        expect(return_value).to eq({ from: "A", to: "z" })
      end
    end

    context "when From value is '<' and To value is '}'" do
      let!(:value1) { "<" }
      let!(:value2) { "}" }

      it "returns { from: '<', to: '\\}' } hash with regex escaped values" do
        expect(return_value).to eq({ from: "<", to: "\\}" })
      end
    end

    context "when values are not in the correct range based on ascii value" do
      let!(:value1) { "~" }
      let!(:value2) { "!" }

      it "raises a RangeError error" do
        expect do
          return_value
        end.to raise_error(RangeError)
      end
    end

    context "when values given are not a single ascii character" do
      let!(:value1) { "的" }
      let!(:value2) { 1234 }

      it "raises InvalidValueError error with 'Value should only be a single character in the ascii table' as error message" do
        expect do
          return_value
        end.to raise_error(Regexer::Exceptions::InvalidValueError)
          .with_message("Value should only be a single character in the ascii table")
      end
    end
  end
end
