# frozen_string_literal: true

RSpec.shared_examples "contains method test examples" do |test_cases|
  context "when creating a regex pattern for matching a set of given characters" do
    test_cases.each do |test_case|
      context test_case[:case] do
        let!(:val) { test_case[:test_value] }

        it(test_case[:custom_assertion_message] || "returns #{test_case[:expected_value].inspect} regex pattern") do
          expect(pattern).to eq(test_case[:expected_value])
        end
      end
    end
  end
end

RSpec.shared_examples "contains method invalid value error test example" do |value:|
  context "when value is NOT a string or an integer or a float" do
    let!(:val) { value }

    it "raises InvalidValueError error" do
      expect { pattern }.to raise_error(Regexer::Exceptions::InvalidValueError)
        .with_message("Value should only be of type String or Integer or Float")
    end
  end
end
