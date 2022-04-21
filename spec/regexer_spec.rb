# frozen_string_literal: true

# rubocop:disable Metrics/BlockLength

require "regexer"
require "regexer/exceptions/invalid_from_to_range_error"

RSpec.describe Regexer do
  it "has a version number" do
    expect(Regexer::VERSION).not_to be nil
  end
end

RSpec.describe Regexer::Pattern do
  describe "#regex" do
    context "when creating a regex pattern for matching a letter in a range A-z" do
      it "returns /[A-z]+/ regex pattern" do
        pattern = Regexer::Pattern.new.regex do
          has_letters from: "A", to: "z"
        end

        expect(pattern).to eq(/[A-z]+/)
      end

      context "when From value is greater than the To value in terms of ASCII value" do
        it "raises a InvalidFromToRangeError error" do
          expect do
            Regexer::Pattern.new.regex do
              has_letters from: "a", to: "Z"
            end
          end.to raise_error(Regexer::Exceptions::InvalidFromToRangeError)
        end
      end

      context "when From value or To value is NOT a single letter" do
        it "raises InvalidValueError error with 'Value should only be a single letter' as error message" do
          expect do
            Regexer::Pattern.new.regex do
              has_letters from: "test", to: 239
            end
          end.to raise_error(Regexer::Exceptions::InvalidValueError)
            .with_message("Value should only be a single letter")
        end
      end
    end

    context "when creating a regex pattern for matching a number in a range 0-9" do
      it "returns /[0-9]+/ regex pattern" do
        pattern = Regexer::Pattern.new.regex do
          has_numbers from: 0, to: 9
        end

        expect(pattern).to eq(/[0-9]+/)
      end

      context "when From value is greater than the To value" do
        it "raises InvalidFromToRangeError error" do
          expect do
            Regexer::Pattern.new.regex do
              has_numbers from: 9, to: 0
            end
          end.to raise_error(Regexer::Exceptions::InvalidFromToRangeError)
        end
      end

      context "when From value or To value is NOT an integer from 0 to 9" do
        it "raises InvalidValueError error with 'Value should only be an integer from 0 to 9' as error message" do
          expect do
            Regexer::Pattern.new.regex do
              has_numbers from: -2, to: 92
            end
          end.to raise_error(Regexer::Exceptions::InvalidValueError)
            .with_message("Value should only be an integer from 0 to 9")
        end
      end
    end

    context "when creating a regex pattern for matching a set of given characters" do
      context "when value is an exact integer: 26543" do
        it "returns /26543/ regex pattern" do
          pattern = Regexer::Pattern.new.regex do
            contains 26_543
          end

          expect(pattern).to eq(/26543/)
        end
      end

      context "when value is an exact float: 3.56" do
        it "returns /3\.56/ regex pattern" do
          pattern = Regexer::Pattern.new.regex do
            contains 3.56
          end

          expect(pattern).to eq(/3\.56/)
        end
      end

      context "when value is an exact set of characters: 'testing'" do
        it "returns /testing/ regex pattern" do
          pattern = Regexer::Pattern.new.regex do
            contains "testing"
          end

          expect(pattern).to eq(/testing/)
        end
      end

      context "when value contains regex special characters" do
        it "escapes those special characters in the final generated pattern" do
          pattern = Regexer::Pattern.new.regex do
            contains ".+*?^$()[]{}|\\"
          end

          expect(pattern).to eq(/\.\+\*\?\^\$\(\)\[\]\{\}\|\\/)
        end
      end

      context "when value is NOT a string or an integer or a float" do
        it "raises InvalidValueError error" do
          expect do
            Regexer::Pattern.new.regex do
              contains(/test/)
            end
          end.to raise_error(Regexer::Exceptions::InvalidValueError)
            .with_message("Value should only be of type String or Integer or Float")
        end
      end
    end

    context "when creating a regex pattern for matching a set of given characters in the beginning of strings" do
      context "when value is an exact integer: 26543" do
        it "returns /^(26543)/ regex pattern" do
          pattern = Regexer::Pattern.new.regex do
            starts_with 26_543
          end

          expect(pattern).to eq(/^(26543)/)
        end
      end

      context "when value is an exact float: 3.56" do
        it "returns /^(3\.56)/ regex pattern" do
          pattern = Regexer::Pattern.new.regex do
            starts_with 3.56
          end

          expect(pattern).to eq(/^(3\.56)/)
        end
      end

      context "when value is an exact set of characters: 'testing'" do
        it "returns /^(testing)/ regex pattern" do
          pattern = Regexer::Pattern.new.regex do
            starts_with "testing"
          end

          expect(pattern).to eq(/^(testing)/)
        end
      end

      context "when value contains regex special characters" do
        it "escapes those special characters in the final generated pattern" do
          pattern = Regexer::Pattern.new.regex do
            starts_with ".+*?^$()[]{}|\\"
          end

          expect(pattern).to eq(/^(\.\+\*\?\^\$\(\)\[\]\{\}\|\\)/)
        end
      end

      context "when value is NOT a string or an integer or a float" do
        it "raises InvalidValueError error" do
          expect do
            Regexer::Pattern.new.regex do
              starts_with(/test/)
            end
          end.to raise_error(Regexer::Exceptions::InvalidValueError)
            .with_message("Value should only be of type String or Integer or Float")
        end
      end
    end

    context "when creating a regex pattern for matching a set of given characters in the end of strings" do
      context "when value is an exact integer: 26543" do
        it "returns /(26543)$/ regex pattern" do
          pattern = Regexer::Pattern.new.regex do
            ends_with 26_543
          end

          expect(pattern).to eq(/(26543)$/)
        end
      end

      context "when value is an exact float: 3.56" do
        it "returns /(3\.56)$/ regex pattern" do
          pattern = Regexer::Pattern.new.regex do
            ends_with 3.56
          end

          expect(pattern).to eq(/(3\.56)$/)
        end
      end

      context "when value is an exact set of characters: 'testing'" do
        it "returns /(testing)$/ regex pattern" do
          pattern = Regexer::Pattern.new.regex do
            ends_with "testing"
          end

          expect(pattern).to eq(/(testing)$/)
        end
      end

      context "when value contains regex special characters" do
        it "escapes those special characters in the final generated pattern" do
          pattern = Regexer::Pattern.new.regex do
            ends_with ".+*?^$()[]{}|\\"
          end

          expect(pattern).to eq(/(\.\+\*\?\^\$\(\)\[\]\{\}\|\\)$/)
        end
      end

      context "when value is NOT a string or an integer or a float" do
        it "raises InvalidValueError error" do
          expect do
            Regexer::Pattern.new.regex do
              ends_with(/test/)
            end
          end.to raise_error(Regexer::Exceptions::InvalidValueError)
            .with_message("Value should only be of type String or Integer or Float")
        end
      end
    end
  end
end
# rubocop:enable Metrics/BlockLength
