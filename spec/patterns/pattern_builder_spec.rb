# frozen_string_literal: true

require "regexer"

RSpec.describe Regexer::PatternBuilder do
  describe "Instance Methods" do
    let(:pattern_block) do
      -> { contains "a" }
    end

    context "#result" do
      it "returns a Regexer::Models::Pattern object" do
        expect(described_class.new(&pattern_block).result).to be_a Regexer::Models::Pattern
      end
    end

    context "#append_pattern" do
      context "when pattern builder has an already built pattern" do
        it "appends another set of patterns to the pattern builder result" do
          pattern_builder = described_class.new(&pattern_block)
          pattern_builder.append_pattern do
            has_word_character
          end

          expect(pattern_builder.result.raw_pattern).to eq "a\\w"
        end
      end
    end
  end
end
