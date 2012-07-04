MO
==

Mo helps you keep your rails project clean.

Installation
------------

Install it with rubygems:

    gem install mo

With bundler, add it to your `Gemfile`:

``` ruby
gem "mo", "~>0.1.0"
```

Without rails, added those lines to `Rakefile` :

``` ruby
require 'mo'
load 'mo/tasks.rake'
```

Rake tasks :

    rake mo:encoding                         # Add utf-8 encoding on files that don't have it
    rake mo:rocketless                       # Convert ruby hashes to 1.9 style.
    rake mo:whitespace                       # Clean-up trailing whitespaces.


Copyright
---------

MIT. See LICENSE for further details.
