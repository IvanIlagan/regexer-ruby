# frozen_string_literal: true

require "regexer"

RSpec.describe "Regexer::Pattern #_or_" do
  let(:pattern_block) do
    -> { _or_ }
  end

  subject(:pattern) do
    Regexer::PatternBuilder.new(&pattern_block).result.regex
  end

  it "adds the or character special regex character in the final pattern" do
    expect(pattern).to eq(/|/)
  end
end
