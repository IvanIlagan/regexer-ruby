## [1.1.0] (October 09, 2022)
## Changes
* Added a new pattern method called has_any_character_not_in. Basically this is the inverse of the has_any_character_in method in which this creates a regex pattern in the format: [^<characters_specified>]
* Bugfix on the character_range method in which it raises an error when given special characters in regex.
* When a Hash with keys from & to contains a regex special character, it will now escape those characters instead of taking it as is in the final pattern.

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
