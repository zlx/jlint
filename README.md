# Jlint

![](https://travis-ci.org/zlx/jlint.svg?branch=master)

Ruby Warp for CheckStyle: https://github.com/checkstyle/checkstyle

Provide more friendly interface for Rubist

## Installation

Add this line to your application's Gemfile:

    gem 'jlint'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install jlint

## Dependency

1. JRE

## Usage

```ruby
  Jlint.lint(content)         #=> [[message, line], ...]
  Jlint.file_lint(file_path)  #=> [[message, line], ...]

# Default it use [sun checks]()
# If Want to custom config

  lint = Jlint.new(config_content)
  lint.lint(content)          #=> [[message, line], ...]
```

## Contributing

1. Fork it ( http://github.com/<my-github-username>/jlint/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
