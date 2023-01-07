## [1.2.0] (January 07, 2023)
## Changes
* Added: new pattern methods based on the ff regex shorthand characters: \D, \n, \t, \W, \S, \b, \r, \v, \f.
* Added: Regexer::PatternBuilder new instance method ```append_pattern``` which allows to append patterns to the Regexer:PatternBuilder instance.
* Added: add operation to Regexer::Models::Pattern object. This allows to add two different results of pattern builders together to form a singular pattern.
* Added: ```any_character_in``` and ```any_character_not_in``` methods now accepts pattern methods as value inputs. But the values should be a Pattern object tagged as regex shorthand character.
* Fixed: ```has_any_character_not_in``` method, when chaining other pattern methods, does not generate a pattern including a duplicate copy of the chained pattern method result.
* Fixed: ```Regexer::PatternBuilder.new {}.result``` always return a Regexer::Models::Pattern object with a new instance of the pattern value.

**Full Changelog**: https://github.com/IvanIlagan/regexer-ruby/commits/v1.2.0

## [1.1.0] (October 09, 2022)
## Changes
* Added a new pattern method called has_any_character_not_in. Basically this is the inverse of the has_any_character_in method in which this creates a regex pattern in the format: [^<characters_specified>]
* Bugfix on the character_range method when used as input for the has_any_character_in or has_any_character_not_in methods in which it raises an error when given special characters in regex.
* When a Hash with keys from & to contains a regex special character is used as input for the has_any_character_in or has_any_character_not_in methods, it will now escape those characters instead of taking it as is in the final pattern. This fixes the issue when the from value is the character '^' and that hash is the first input to the has_any_character_in method, regex will not interpret it as a character range but instead a negate value and then proceeded by the '-' character and to value character

**Full Changelog**: https://github.com/IvanIlagan/regexer-ruby/commits/v1.1.0


## [1.0.0] (August 09, 2022)
# First Functional Release

## Features
* Build regex patterns in a more english sentence way by using the available DSL methods. Mix and match the DSL methods in order for you to build regex patterns more english like.
* So far this release allows you to use the following special regex characters: ^, $, +, *, ?, .
* For shorthand characters, the following are available: \w, \d, \s
* There are a few ease of use DSL methods available for easier building of regex patterns like #letter(from: "A", to: "z"), #has_alphanumeric_character etc...

Feel free to check the [GETTING_STARTED](./GETTING_STARTED.md) page to check all available methods and some example usage.

**Full Changelog**: https://github.com/IvanIlagan/regexer-ruby/commits/v1.0.0

## [0.1.0] (March 17, 2022)

- Initial Creation/Commit
