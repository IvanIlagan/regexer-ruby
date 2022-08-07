# frozen_string_literal: true

require "regexer"

RSpec.describe "Regexer::Pattern #has_any_character_except_new_line" do
  let(:pattern_block) do
    -> { has_any_character_except_new_line }
  end

  subject(:pattern) do
    Regexer::PatternBuilder.new(&pattern_block).result.regex
  end

  context "when string being matched is 'h'" do
    it "is a match" do
      expect("h".match?(pattern)).to eq true
    end
  end

  context "when string being matched is 'Z'" do
    it "is a match" do
      expect("Z".match?(pattern)).to eq true
    end
  end

  context "when string being matched is '0'" do
    it "is a match" do
      expect("0".match?(pattern)).to eq true
    end
  end

  context "when string being matched is '@'" do
    it "is a match" do
      expect("@".match?(pattern)).to eq true
    end
  end

  context "when string being matched is '}'" do
    it "is a match" do
      expect("}".match?(pattern)).to eq true
    end
  end

  context "when string being matched is '재'" do
    it "is a match" do
      expect("재".match?(pattern)).to eq true
    end
  end

  context "when string being matched is '\\n'" do
    it "is NOT a match" do
      expect("\n".match?(pattern)).to eq false
    end
  end

  context "when any_character_except_new_line alias method is used" do
    let!(:pattern_block) do
      -> { any_character_except_new_line }
    end

    it "returns /./ regex pattern" do
      expect(pattern).to eq(/./)
    end
  end
end
