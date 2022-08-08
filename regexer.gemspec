# frozen_string_literal: true

require_relative "lib/regexer/version"

Gem::Specification.new do |spec|
  spec.name          = "regexer"
  spec.version       = Regexer::VERSION
  spec.authors       = ["Genesis Ivan Ilagan"]
  spec.email         = ["ivanilagan1109@gmail.com"]

  spec.summary       = "A ruby DSL for generating regex patterns"
  spec.description   = "A ruby DSL for building regex patterns in a human readable format. Regexer aims in making regex more easily read, learned and understood at first glance. Syntax wise, it is inspired by FactoryBot and RSpec"
  spec.homepage      = "https://github.com/IvanIlagan/regexer-ruby"
  spec.license       = "MIT"
  spec.required_ruby_version = ">= 2.5.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/IvanIlagan/regexer-ruby"
  spec.metadata["changelog_uri"] = "https://github.com/IvanIlagan/regexer-ruby/blob/main/CHANGELOG.md"

  spec.files = `git ls-files -- lib/*`.split("\n")
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "pry", "~> 0.13.1"
  spec.add_development_dependency "rake", "~> 13.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "rubocop", "~> 1.7"

  # For more information and examples about making a new gem, checkout our
  # guide at: https://bundler.io/guides/creating_gem.html
end
