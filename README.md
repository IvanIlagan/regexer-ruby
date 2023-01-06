# Regexer

A ruby DSL for building regex patterns in a human readable format. Regexer aims in making regex more easily read, learned and understood at first glance. Syntax wise, it is inspired
by FactoryBot and RSpec

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

Require Regexer in your ruby file and give a block to the instance of Regexer::PatternBuilder class

```ruby
# require the gem
require 'regexer'

# Build your regex patterns within a block right after instantiating Regexer::PatternBuilder class
pattern_builder = Regexer::PatternBuilder.new do
  has_letter from: "A", to: "z"
  has_number from: 0, to: 9
end

pattern = pattern_builder.result # Get the result of the pattern builder by calling the result method in which it returns a Regexer::Models::Pattern object

puts pattern.raw_pattern
# outputs '[A-z][0-9]'

puts pattern.regex
# outputs /[A-z][0-9]/
```

See [GETTING_STARTED](./GETTING_STARTED.md) for indepth details on usage and the documentation for the available DSL methods.

## Examples
Starts With Repeating Word "dog"
```ruby
require 'regexer'

pattern_builder = Regexer::PatternBuilder.new do
  starts_with consecutive_instances_of "dog"
end

pattern = pattern_builder.result

puts pattern.regex
# outputs /^((dog)+)/
```

Any Word With Only Three Letters In It
```ruby
require 'regexer'

pattern_builder = Regexer::PatternBuilder.new do
  contains_a_word_with consecutive_instances_of word_character, exactly: 3
end

pattern = pattern_builder.result

puts pattern.regex
# outputs /\b(\w{3})\b/
```

Basic Email Address
```ruby
require 'regexer'

pattern_builder = Regexer::PatternBuilder.new do
  has_consecutive_instances_of word_character
  contains "@"
  has_consecutive_instances_of word_character
  contains "."
  has_consecutive_instances_of letter from: "a", to: "z"
end

pattern = pattern_builder.result

puts pattern.regex
# outputs /\w+@\w+\.[a-z]+/
```

Ends With Consecutive Group of Patterns
```ruby
require 'regexer'

pattern_builder = Regexer::PatternBuilder.new do
  ends_with consecutive_instances_of group {
    has_ascii_character from: "<", to: "z"
    contains "-"
    has_number from: 4, to: 5
  }
end

pattern = pattern_builder.result

puts pattern.regex
# outputs /(([<-z]\-[4-5])+)$/
```

Negative Numbers
```ruby
require 'regexer'

pattern_builder = Regexer::PatternBuilder.new do
  has_none_or_one_instance_of "-"
  has_consecutive_instances_of digit_character
end

pattern = pattern_builder.result

puts pattern.regex
# outputs /\-?\d+/
```

DD/MM/YYYY Date Format
```ruby
require 'regexer'

pattern_builder = Regexer::PatternBuilder.new do
  starts_with group {
    contains 0
    has_number from: 1, to: 9
    _or_
    has_any_character_in 12
    has_number from: 0, to: 9
    _or_
    contains 3
    has_any_character_in "01" 
  }
  contains "/"
  has_group {
    contains 0
    has_number from: 1, to: 9
    _or_
    contains 1
    has_number from: 0, to: 2
  }
  contains "/"
  ends_with consecutive_instances_of(digit_character, exactly: 4)
end

pattern = pattern_builder.result

puts pattern.regex
# outputs /^(0[1-9]|[12][0-9]|3[01])\/(0[1-9]|1[0-2])\/(\d{4})$/
```

Philippines Mobile Number Format (09XX XXX XXXX)
```ruby
require 'regexer'

pattern_builder = Regexer::PatternBuilder.new do
  contains "09"
  has_consecutive_instances_of(digit_character, exactly: 2)
  contains " "
  has_consecutive_instances_of(digit_character, exactly: 3)
  contains " "
  has_consecutive_instances_of(digit_character, exactly: 4)
end

pattern = pattern_builder.result

puts pattern.regex
# outputs /(09)\d{2}\ \d{3}\ \d{4}/
```

Hex Color Codes
```ruby
require 'regexer'

pattern_builder = Regexer::PatternBuilder.new do
  starts_with none_or_one_instance_of "#"
  ends_with group {
    has_consecutive_instances_of(
      any_character_in(
        character_range(from: "a", to: "f"),
        character_range(from: "A", to: "F"),
        character_range(from: "0", to: "9")
      ),
      exactly: 6
    )

    _or_

    has_consecutive_instances_of(
      any_character_in(
        character_range(from: "a", to: "f"),
        character_range(from: "A", to: "F"),
        character_range(from: "0", to: "9")
      ),
      exactly: 3
    )
  }
end

pattern = pattern_builder.result

puts pattern.regex
# outputs /^(\#?)([a-fA-F0-9]{6}|[a-fA-F0-9]{3})$/
```
## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/IvanIlagan/regexer-ruby. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/IvanIlagan/regexer-ruby/blob/master/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Regexer project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/IvanIlagan/regexer-ruby/blob/master/CODE_OF_CONDUCT.md).
