# frozen_string_literal: true

require "regexer"

RSpec.describe "Regexer::Pattern #has_group" do
  let(:pattern_block) do
    lambda do
      has_group do
        has_consecutive word_character
        contains "@"
        has_number from: 0, to: 9
      end
    end
  end

  subject(:pattern) do
    Regexer::PatternBuilder.new(&pattern_block).result.regex
  end

  context "when block is given" do
    it "builds regex pattern specified within a block and closes those in parenthesis" do
      expect(pattern).to eq(/(\w+@[0-9])/)
    end

    context "when alias method is used" do
      it "builds regex pattern specified within a block and closes those in parenthesis" do
        expect(pattern).to eq(/(\w+@[0-9])/)
      end
    end

    context "when invalid values are used within the block" do
      let!(:pattern_block) do
        lambda do
          has_group do
            has_number from: "A", to: "z"
          end
        end
      end

      it "raises an error" do
        expect { pattern }.to raise_error(Regexer::Exceptions::InvalidValueError)
      end
    end
  end

  context "when block is NOT given" do
    let!(:pattern_block) do
      lambda do
        has_group
      end
    end

    it "raises NoBlockGivenError error" do
      expect { pattern }.to raise_error(Regexer::Exceptions::NoBlockGivenError)
    end
  end
end
