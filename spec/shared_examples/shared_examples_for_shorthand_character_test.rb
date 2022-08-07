# frozen_string_literal: true

RSpec.shared_examples "shorthand character method test examples" do |shorthand_character, test_cases|
  context "when creating a regex pattern with the shorthand character #{shorthand_character}" do
    test_cases.each do |test_case|
      context test_case[:case] do
        it(test_case[:custom_assertion_message] || "returns #{test_case[:expected_value].inspect} regex pattern", if: test_case[:expected_value]) do
          expect(pattern).to eq(test_case[:expected_value])
        end

        it "is a match with the #{shorthand_character}", if: test_case[:test_value] do
          expect(test_case[:test_value].match?(pattern)).to eq true
        end

        it "is NOT a match with the #{shorthand_character}", if: test_case[:fail_value] do
          expect(test_case[:fail_value].match?(pattern)).to eq false
        end
      end
    end
  end
end
