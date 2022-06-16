# frozen_string_literal: true

RSpec.shared_examples "has_word_character method test examples" do |test_cases|
  context "when creating a regex pattern for matching a set of word character" do
    test_cases.each do |test_case|
      context test_case[:case] do
        it(test_case[:custom_assertion_message] || "returns #{test_case[:expected_value].inspect} regex pattern", if: test_case[:expected_value]) do
          expect(pattern).to eq(test_case[:expected_value])
        end

        it "is a match with the /\\w/ regex pattern", if: test_case[:test_value] do
          expect(test_case[:test_value].match?(pattern)).to eq true
        end
      end
    end
  end
end
