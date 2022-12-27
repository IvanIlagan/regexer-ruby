# frozen_string_literal: true

require "regexer"

RSpec.describe "Regexer::Pattern #has_alphanumeric_character" do
  let(:pattern_block) do
    -> { has_alphanumeric_character }
  end

  subject(:pattern) do
    Regexer::PatternBuilder.new(&pattern_block).result.regex
  end

  context "when method is called" do
    it "returns a Regexer::Models::Pattern object" do
      expect(Regexer::PatternBuilder.new(&pattern_block).send(:has_alphanumeric_character)).to be_a Regexer::Models::Pattern
    end
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

  context "when string being matched is '!'" do
    it "is NOT a match" do
      expect("!".match?(pattern)).to eq false
    end
  end

  context "when alphanumeric_character alias method is used" do
    let!(:pattern_block) do
      -> { alphanumeric_character }
    end

    it "returns /[A-Za-z0-9]/ regex pattern" do
      expect(pattern).to eq(/[A-Za-z0-9]/)
    end
  end
end
