# frozen_string_literal: true

require "regexer"
require "./spec/shared_examples/shared_examples_for_contains_test"
require "pry"

RSpec.describe "Regexer::Pattern #has_any_character_not_in" do
  let(:val) { nil }

  let(:pattern_block) do
    lambda do |value|
      -> { has_any_character_not_in value }
    end.call(val)
  end

  subject(:pattern) do
    Regexer::PatternBuilder.new(&pattern_block).result.regex
  end

  context "when any_character_not_in alias method is used" do
    let!(:val) { 3.56 }
    let!(:pattern_block) do
      lambda do |value|
        -> { any_character_not_in value }
      end.call(val)
    end

    it "functions the same as its original method name" do
      expect(pattern).to eq(/[^3\.56]/)
    end
  end

  context "when value is a valid hash" do
    context "when character_range(from: 'a', to: 'z') return value is given" do
      let(:pattern_block) do
        -> { has_any_character_not_in character_range from: "a", to: "z" }
      end

      it "builds /[^a-z]/ regex pattern" do
        expect(pattern).to eq(/[^a-z]/)
      end
    end

    context "when a manually entered hash is given" do
      context "when hash has a special character in regex" do
        let!(:pattern_block) do
          -> { has_any_character_not_in({ from: "-", to: "^" }) }
        end

        # LUCKILY REGEX DOESN'T INTERPRET SPECIAL CHARACTERS
        # IT JUST TAKES IT AS IS
        # EXCEPTION THOUGH IS THE ^ SYMBOL SINCE IT MEANS NEGATION IF SPECIFIED
        # AS THE FIRST CHARACTER
        it "builds /[^--^]/ regex pattern unescaped" do
          expect(pattern).to eq(/[^--^]/)
        end
      end

      context "when hash DOES NOT HAVE a special character in regex" do
        let!(:pattern_block) do
          -> { has_any_character_not_in({ from: "a", to: "z" }) }
        end

        it "builds /[^a-z]/ regex pattern as is" do
          expect(pattern).to eq(/[^a-z]/)
        end
      end

      context "when range in hash is invalid" do
        let!(:pattern_block) do
          -> { has_any_character_not_in({ from: "z", to: "a" }) }
        end

        it "raises InvalidValueError error" do
          expect { pattern }.to raise_error(RangeError)
        end
      end

      context "when hash has invalid from or to values" do
        let!(:pattern_block) do
          -> { has_any_character_not_in({ from: 2, to: /test/ }) }
        end

        it "raises InvalidValueError error with 'Value should only be a single character in the ascii table' as error message" do
          expect do
            pattern
          end.to raise_error(Regexer::Exceptions::InvalidValueError)
            .with_message("Value should only be a single character in the ascii table")
        end
      end
    end
  end

  # NOTE: Under the hood, has_any_character_not_in method has almost the same behaviour as has_any_character_in method
  context "when value is NOT a hash" do
    include_examples "contains method test examples", [
      {
        case: "when value is an exact integer: 26543",
        test_value: 26_543,
        expected_value: /[^26543]/
      },
      {
        case: "when value is an exact float: 3.56",
        test_value: 3.56,
        expected_value: /[^3\.56]/
      },
      {
        case: "when value is an exact set of characters: 'testing'",
        test_value: "testing",
        expected_value: /[^testing]/
      },
      {
        case: "when value contains regex special characters",
        test_value: ".+*?^$()[]{}|\\",
        custom_assertion_message: "escapes those special characters in the final generated pattern",
        expected_value: /[^\.\+\*\?\^\$\(\)\[\]\{\}\|\\]/
      }
    ]

    context "when value is the ff string: 'a-z'" do
      let!(:pattern_block) do
        -> { has_any_character_not_in "a-z" }
      end

      it "escapes the hyphen" do
        expect(pattern).to eq(/[^a\-z]/)
      end
    end
  end

  context "when multiple valid values are given" do
    let!(:pattern_block) do
      lambda do
        has_any_character_not_in "dog",
                              character_range(from: "!", to: "/"),
                              12_345
      end
    end

    it "combines all values to be built as a single regex pattern" do
      expect(pattern).to eq(%r{[^dog!-/12345]})
    end
  end

  context "when value is NOT a string or an integer or a hash with from & to keys" do
    let!(:val) { /test/ }

    it "raises InvalidValueError error" do
      expect { pattern }.to raise_error(Regexer::Exceptions::InvalidValueError)
        .with_message("Value should only be of type String or Integer or Hash with from & to keys")
    end
  end

  context "when value is an invalid hash" do
    context "when hash has keys ordered in ff: to, from" do
      let!(:val) { { to: "z", from: "a" } }

      it "raises InvalidValueError error" do
        expect { pattern }.to raise_error(Regexer::Exceptions::InvalidValueError)
          .with_message("Value should only be of type String or Integer or Hash with from & to keys")
      end
    end

    context "when hash has no from or to keys" do
      let!(:val) { { from: "a", test: "z" } }

      it "raises InvalidValueError error" do
        expect { pattern }.to raise_error(Regexer::Exceptions::InvalidValueError)
          .with_message("Value should only be of type String or Integer or Hash with from & to keys")
      end
    end
  end
end
