# Getting Started
- [Building patterns](#building-patterns)
  - [Layout](#layout)
  - [Adding patterns](#adding-patterns)
  - [Using the final pattern](#using-the-final-pattern)
- [Patterns](#patterns)
  - [Standalone Patterns](#standalone-patterns)
    - [Letter in a given range](#letter-in-a-given-range)
    - [Number in a given range](#number-in-a-given-range)
    - [Word Character](#word-character)
  - [Chainable Patterns](#chainable-patterns)
    - [Group of characters](#group-of-characters)
    - [Starts with a group of characters](#starts-with-a-group-of-characters)
    - [Ends with a group of characters](#ends-with-a-group-of-characters)
    - [Consecutive group of characters](#consecutive-group-of-characters)
    - [None or consecutive group of characters](#none-or-consecutive-group-of-characters)

## Building Patterns
## Layout
When building your regex patterns with regexer, always instantiate the Regexer::PatternBuilder class and give it a block
```ruby
Regexer::PatternBuilder.new do
  # patterns here
end
```

## Adding patterns
To start adding your patterns, just call the available [pattern methods](#patterns) and supply them values based on your needs.

Highly recommend to add your patterns line by line. This is because the pattern builder builds the pattern from left to right.

```ruby
Regexer::PatternBuilder.new do
  starts_with "Hi!"             # builds "^(Hi!)"
  has_letter from: "A", to: "z" # builds "[A-z]"
  has_number from: 0, to: 9     # builds "[0-9]"
  ends_with "Bye"               # builds "(Bye)$"
end

# Based on the above pattern, it will have this as the final built pattern: "^(Hi!)[A-z][0-9](Bye)$"
```

In addition, you can chain the pattern methods together to build a much more customized human readable pattern. Mix and match the pattern methods based on your needs and expressiveness.
```ruby
Regexer::PatternBuilder.new do
  starts_with consecutive letter from: "A", to: "z" # builds "^([A-z]+)"
  contains number from: 0, to: 9                    # builds "([0-9])"
end

# Based on the above pattern, it will have this as the final built pattern: "^([A-z]+)([0-9])"
```

So far, very few methods allow that kind of chain. See [here](#chainable-patterns) for the full list of chainable pattern methods

## Using the final pattern
Once you finished building your pattern, you need to call the result method of the PatternBuilder class to get the final built pattern from the pattern builder.

The result method will return a Regexer::Models::Pattern object. The object has the following methods:
- raw_pattern
- regex

The raw_pattern method returns the final built pattern as a string while the regex method returns the final built pattern as a Regexp object.
```ruby
pattern_builder_result = Regexer::PatternBuilder.new do
  starts_with "Hi!"             # builds "^(Hi!)"
  has_letter from: "A", to: "z" # builds "[A-z]"
  has_number from: 0, to: 9     # builds "[0-9]"
  ends_with "Bye"               # builds "(Bye)$"
end.result

puts patter_builder_result.raw_pattern
puts "Hello".match?(patter_builder_result.regex)
```

## Patterns
## Standalone patterns
These are pattern methods that has no parameters or if given a parameter, they don't accept Regexer::Models::Pattern objects.

### Letter in a given range
In regex, we mostly do this pattern in matching a text if it contains a letter within a certain range: /[A-z]/

In regexer, its equivalent is the has_letter or letter method
```ruby
Regexer::PatternBuilder.new do
  has_letter from: "A", to: "z"
  letter from: "A", to: "z"
end
```

The method requires 2 keyword arguments named from and to in which we can only assign a string value to each of them.

In line with the method name, the arguments strictly accepts only 1 character string that is any letter in the english alphabet. Also the value for the from argument should always be lower than the to argument value in terms of ascii value. If an invalid value is given, an exception is raised.

### Number in a given range
In regex, we mostly do this pattern in matching a text if it contains a number within a certain range: /[0-9]/

In regexer, its equivalent is the has_number or number method
```ruby
Regexer::PatternBuilder.new do
  has_number from: 0, to: 9
  number from: 0, to: 9
end
```

The method requires 2 keyword arguments named from and to in which we can only assign a positive integer value to each of them. Also the value for the from argument should always be lower than the to argument value. If an invalid value is given, an exception is raised.

### Word Character
In regex, there is a special pattern that matches any alphanumeric character and underscore with just 2 characters and that is the \w or Word pattern. Regexer also offers that exact pattern via the has_word_character or word_character method.
```ruby
Regexer::PatternBuilder.new do
  has_word_character
  word_character
end
```

The method does not accept any arguments. We can freely call it as is in the pattern builder.

## Chainable patterns
These are pattern methods that not only accepts strict set of data types but it also accepts a Regexer::Models::Pattern objects as arguments. What makes these methods chainable is that all of the methods used here all return a Regexer::Models::Pattern object. Given that, we can call another pattern method as the paramater instead of the other data types for more expressiveness.

### Group of characters
Just like in regex, regexer offers a method called contains that allows us to generate a pattern for finding groups of characters or substrings via the parenthesis in regex.
```ruby
Regexer::PatternBuilder.new do
  contains "test"
  contains 1234
  contains 5.43
  contains "+-/hey__$^"
end
```

The method accepts one argument in which it can be a string, integer, float and even the Regexer::Models::Pattern object. If an invalid value is given, an exeption is raised

Keep in mind that when using this method, it escapes characters that has a special function in regex.

### Starts with a group of characters
Just like in regex, regexer offers a method called starts_with that allows us to generate a pattern for finding groups of characters or substrings at the beginning of text
```ruby
Regexer::PatternBuilder.new do
  starts_with "test"
  starts_with 1234
  starts_with 5.43
  starts_with "+-/hey__$^"
end
```

The method behaves exactly the same with the contains method, the only difference is that it adds the "^" character at the beginning of the given value

### Ends with a group of characters
Just like in regex, regexer offers a method called ends_with that allows us to generate a pattern for finding groups of characters at the end of text
```ruby
Regexer::PatternBuilder.new do
  ends_with "test"
  ends_with 1234
  ends_with 5.43
  ends_with "+-/hey__$^"
end
```

The method behaves exactly the same with the contains method, the only difference is that it adds the "$" character at the end of the given value

### Consecutive group of characters
In regex, we have the special character '+' that allows us to match a text that has consecutive repeating character or group of characters. We can use that special character by calling the has_consecutive or consecutive method

```ruby
Regexer::PatternBuilder.new do
  has_consecutive "test"
  has_consecutive 1234
  consecutive 5.43
  consecutive "+-/hey__$^"
end
```

It also functions the same as the contains method since it is being used by it behind the scenes to build the pattern and then the method itself just appends the '+' character at the end of it.

### None or consecutive group of characters
In regex, we have the special character '*' that allows us to match a text that has none or consecutive repeating character or group of characters. We can use that special character by calling the has_none_or_consecutive or none_or_consecutive method

```ruby
Regexer::PatternBuilder.new do
  has_none_or_consecutive "test"
  has_none_or_consecutive 1234
  none_or_consecutive 5.43
  none_or_consecutive "+-/hey__$^"
end
```

It also functions the same as the contains method since it is being used by it behind the scenes to build the pattern and then the method itself just appends the '*' character at the end of it.