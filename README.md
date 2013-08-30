[![Build Status](https://travis-ci.org/chatgris/mo.png?branch=master)](https://travis-ci.org/chatgris/mo)

# MO

Mo helps you keep your project clean.

[MO](http://disney.wikia.com/wiki/M-O) is for the little robot on WALL-E film.

## Installation

Install it with rubygems:

    gem install mo

With bundler, add it to your `Gemfile`:

``` ruby
gem "mo", "~>1.0"
```

## Usage

```
Usage: mo [OPTIONS] COMMAND [ARGS]

Available commands:
  check_rspec_files_name  Check rspec's files name
  check_syntax            Check ruby syntax.
  eighty_column           Print files with more than 80 columns
  encoding                Add utf-8 encoding on files that don't have it
  help                    Displays help for a command
  rocketless              Convert ruby hashes to 1.9 style.
  whitespace              Clean-up trailing whitespaces.
  unbreakable             Print files with unbreakable space.

Options:
  -h, --help  Displays this help message
```

## Copyright

MIT. See LICENSE for further details.
