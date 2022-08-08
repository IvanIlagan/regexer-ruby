# frozen_string_literal: true

require "regexer"
require "regexer/exceptions/invalid_value_error"
require "./spec/shared_examples/shared_examples_for_contains_test"
require "pry"

RSpec.describe "Regexer::Pattern #has_consecutive_instances_of" do
  let(:pattern_block) do
    -> { has_consecutive_instances_of nil }
  end

  subject(:pattern) do
    Regexer::PatternBuilder.new(&pattern_block).result.regex
  end

  context "when consecutive_instances_of alias method is used" do
    let!(:pattern_block) do
      -> { consecutive_instances_of "test" }
    end

    it "returns /(test)+/ regex pattern" do
      expect(pattern).to eq(/(test)+/)
    end
  end

  context "when value is only a string 'test'" do
    let!(:pattern_block) do
      -> { has_consecutive_instances_of "test" }
    end

    it "returns /(test)+/ regex pattern" do
      expect(pattern).to eq(/(test)+/)
    end
  end

  context "when value is only a number" do
    context "when the number is an int 12345" do
      let!(:pattern_block) do
        -> { has_consecutive_instances_of 12_345 }
      end

      it "returns /(12345)+/ regex pattern" do
        expect(pattern).to eq(/(12345)+/)
      end
    end

    context "when the number is a float 56.23" do
      let!(:pattern_block) do
        -> { has_consecutive_instances_of 56.23 }
      end

      it "returns /(56\\.23)+/ regex pattern" do
        expect(pattern).to eq(/(56\.23)+/)
      end
    end
  end

  context "when single entity values are given" do
    context "when value given is a single character" do
      let!(:pattern_block) do
        -> { has_consecutive_instances_of "@" }
      end

      it "does not wrap the character in parentheses" do
        expect(pattern).to eq(/@+/)
      end
    end
  end

  context "when non-single entity values are given" do
    context "when value is a non-single entity pattern object" do
      let(:pattern_block) do
        -> { has_consecutive_instances_of starts_with letter from: "A", to: "z" }
      end

      it "wraps the pattern in parentheses" do
        expect(pattern).to eq(/(^[A-z])+/)
      end
    end
  end

  context "when value is a DSL method" do
    context "when value is 1 DSL method: number" do
      let!(:pattern_block) do
        -> { has_consecutive_instances_of number from: 0, to: 9 }
      end

      it "returns /[0-9]+/ regex pattern" do
        expect(pattern).to eq(/[0-9]+/)
      end
    end

    context "when value is 2 DSL methods chained together: contains letter" do
      let!(:pattern_block) do
        -> { has_consecutive_instances_of contains letter from: "A", to: "z" }
      end

      it "returns /[A-z]+/ regex pattern" do
        expect(pattern).to eq(/[A-z]+/)
      end
    end
  end

  context "when options are specified" do
    context "when exactly option is given to 'letter from: 'A', to:'z' value'" do
      let!(:pattern_block) do
        -> { has_consecutive_instances_of letter(from: "A", to: "z"), exactly: 5 }
      end

      it "returns /[A-z]{5}/ regex pattern" do
        expect(pattern).to eq(/[A-z]{5}/)
      end
    end

    context "when minimum options is given to 'letter from: 'A', to:'z' value'" do
      let!(:pattern_block) do
        -> { has_consecutive_instances_of letter(from: "A", to: "z"), minimum: 5 }
      end

      it "returns /[A-z]{5,}/ regex pattern" do
        expect(pattern).to eq(/[A-z]{5,}/)
      end
    end

    context "when minimum & maximum options is given to 'letter from: 'A', to:'z' value'" do
      let!(:pattern_block) do
        -> { has_consecutive_instances_of letter(from: "A", to: "z"), minimum: 5, maximum: 7 }
      end

      it "returns /[A-z]{5,7}/ regex pattern" do
        expect(pattern).to eq(/[A-z]{5,7}/)
      end
    end

    context "when exactly, minimum & maximum options are given at the same time" do
      let!(:pattern_block) do
        -> { has_consecutive_instances_of letter(from: "A", to: "z"), exactly: 1, minimum: 5, maximum: 7 }
      end

      it "prioritizes using the exactly option in building the pattern" do
        expect(pattern).to eq(/[A-z]{1}/)
      end
    end

    context "when exactly & maximum options are given at the same time" do
      let!(:pattern_block) do
        -> { has_consecutive_instances_of letter(from: "A", to: "z"), exactly: 1, maximum: 7 }
      end

      it "prioritizes using the exactly option in building the pattern" do
        expect(pattern).to eq(/[A-z]{1}/)
      end
    end

    context "when maximum options is given to 'letter from: 'A', to:'z' value'" do
      let!(:pattern_block) do
        -> { has_consecutive_instances_of letter(from: "A", to: "z"), maximum: 7 }
      end

      it "raises ArgumentError error with message 'missing minimum keyword argument'" do
        expect { pattern }.to raise_error(ArgumentError)
          .with_message("missing minimum keyword argument")
      end
    end

    context "when value given to options is NOT an integer" do
      context "when given to exactly option" do
        let!(:pattern_block) do
          -> { has_consecutive_instances_of letter(from: "A", to: "z"), exactly: 1.2 }
        end

        it "raises InvalidValueError error with message 'Value should only be of type Integer'" do
          expect { pattern }.to raise_error(Regexer::Exceptions::InvalidValueError)
            .with_message("Value should only be of type Integer")
        end
      end

      context "when given to minimum option" do
        let!(:pattern_block) do
          -> { has_consecutive_instances_of letter(from: "A", to: "z"), minimum: 1.2 }
        end

        it "raises InvalidValueError error with message 'Value should only be of type Integer'" do
          expect { pattern }.to raise_error(Regexer::Exceptions::InvalidValueError)
            .with_message("Value should only be of type Integer")
        end
      end

      context "when given to maximum option" do
        let!(:pattern_block) do
          -> { has_consecutive_instances_of letter(from: "A", to: "z"), minimum: 1, maximum: "test" }
        end

        it "raises InvalidValueError error with message 'Value should only be of type Integer'" do
          expect { pattern }.to raise_error(Regexer::Exceptions::InvalidValueError)
            .with_message("Value should only be of type Integer")
        end
      end
    end

    context "when minimum option value is greater than maximum option value" do
      let!(:pattern_block) do
        -> { has_consecutive_instances_of letter(from: "A", to: "z"), minimum: 5, maximum: 1 }
      end

      it "raises RangeError error with message 'minimum value is larger than maximum value'" do
        expect { pattern }.to raise_error(RangeError)
          .with_message("minimum value is larger than maximum value")
      end
    end
  end

  context "when value is NOT a string or an integer or a float or a Regexer::Models::Pattern" do
    let!(:pattern_block) do
      -> { has_consecutive_instances_of(/(test)/) }
    end

    it "raises InvalidValueError error with message 'Value should only be of type String or Integer or Float or Regexer::Models::Pattern'" do
      expect { pattern }.to raise_error(Regexer::Exceptions::InvalidValueError)
        .with_message("Value should only be of type String or Integer or Float or Regexer::Models::Pattern")
    end
  end
end
