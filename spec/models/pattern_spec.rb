# frozen_string_literal: true

require "regexer"

RSpec.describe Regexer::Models::Pattern do
  describe "Instance" do
    context "when given pattern value is not a string" do
      it "raises a TypeError" do
        expect { described_class.new(/test/) }.to raise_error(TypeError)
      end
    end

    context "when given pattern value is a string" do
      it "successfully creates a Pattern instance" do
        expect(described_class.new("test")).to be_a Regexer::Models::Pattern
      end

      it "saves a new instance of the given string" do
        given_value = "test"
        expect(described_class.new(given_value).raw_pattern).not_to equal given_value
      end
    end

    describe "Instance Methods" do
      context "#+" do
        context "when non Pattern objects are given" do
          it "raises a TypeError" do
            expect { described_class.new("") + 1 }.to raise_error(TypeError)
          end
        end

        context "when Pattern objects are given" do
          it "returns a new instance of Pattern where its value contains the added Pattern" do
            original_pattern = described_class.new("test")
            to_be_added_pattern = Regexer::Models::Pattern.new(" hello")
            result = original_pattern + to_be_added_pattern

            expect(result).to be_a Regexer::Models::Pattern
            expect(result).not_to equal(original_pattern)
            expect(result.raw_pattern).to eq("test hello")
          end
        end
      end

      context "#raw_pattern" do
        it "returns its main value in string format" do
          expect(described_class.new("test").raw_pattern).to eq "test"
          expect(described_class.new("test").raw_pattern).to be_a String
        end
      end

      context "#regex_escaped?" do
        it "returns a boolean representing if a pattern is already regex escaped or not" do
          expect(described_class.new("test").regex_escaped?).to eq true
        end
      end

      context "#single_entity?" do
        it "returns a boolean representing if a pattern is a single entity or not" do
          expect(described_class.new("test").single_entity?).to eq true
        end
      end

      context "#regex_shorthand_character?" do
        it "returns a boolean representing if a pattern is tagged as regex_shorthand_character or not" do
          expect(described_class.new("test", regex_shorthand_character: true).regex_shorthand_character?).to eq true
        end
      end

      context "#regex" do
        it "returns the regex equivalent of the pattern" do
          expect(described_class.new("test").regex).to eq(/test/)
        end
      end
    end
  end
end
