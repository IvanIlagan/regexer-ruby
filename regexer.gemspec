# frozen_string_literal: true

require_relative "lib/regexer/version"

Gem::Specification.new do |spec|
  spec.name          = "regexer"
  spec.version       = Regexer::VERSION
  spec.authors       = ["Genesis Ivan Ilagan"]
  spec.email         = ["ivanilagan1109@gmail.com"]

  spec.summary       = "A ruby DSL for generating regex patterns"
  spec.description   = spec.summary
  spec.homepage      = "https://github.com/IvanIlagan/regexer-ruby"
  spec.license       = "MIT"
  spec.required_ruby_version = ">= 2.5.0"

  spec.metadata["allowed_push_host"] = "TODO: Set to 'https://mygemserver.com'"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/IvanIlagan/regexer-ruby"
  spec.metadata["changelog_uri"] = "https://github.com/IvanIlagan/regexer-ruby/blob/main/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{\A(?:test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  # spec.add_dependency "example-gem", "~> 1.0"

  spec.add_development_dependency "rake", "~> 13.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "rubocop", "~> 1.7"

  # For more information and examples about making a new gem, checkout our
  # guide at: https://bundler.io/guides/creating_gem.html
end
