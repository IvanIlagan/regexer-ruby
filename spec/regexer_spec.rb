# frozen_string_literal: true

require "regexer"

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
    end
  end
end
