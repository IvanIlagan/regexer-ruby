# Regexer

A ruby DSL for generating regex patterns in a human readable format. Regexer aims in making regex more easily learned and understood at first glance.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'regexer'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install regexer

## Usage

NOTE: Usage is in ongoing improvements. Expect this section to change overtime

Require Regexer in your ruby file and call the regex instance method of Regexer::Pattern class

```ruby
require 'regexer'

pattern = Regexer::Pattern.new do
  # add regexer's built-in keywords and methods here to build desired regex pattern
  has_letters from: "A", to: "z"
  has_numbers from: 0, to: 9
end

print pattern.result

# outputs /[A-z]+[0-9]+/
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/regexer. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/[USERNAME]/regexer/blob/master/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Regexer project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/regexer/blob/master/CODE_OF_CONDUCT.md).
