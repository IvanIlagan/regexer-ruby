# frozen_string_literal: true

require "regexer"

RSpec.describe "Regexer::Pattern #_or_" do
  let(:pattern_block) do
    -> { _or_ }
  end

  subject(:pattern) do
    Regexer::PatternBuilder.new(&pattern_block).result.regex
  end

  context "when method is called" do
    it "returns a Regexer::Models::Pattern object" do
      expect(Regexer::PatternBuilder.new(&pattern_block).send(:_or_)).to be_a Regexer::Models::Pattern
    end
  end

  it "adds the or character special regex character in the final pattern" do
    expect(pattern).to eq(/|/)
  end
end
