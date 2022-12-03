# Osatest

Require MacOS and ruby. 

**osatest** is a tool for testing CLI app (Terminal apps) by monkeying the user interaction (via key events). So, it's a "real-time and real-world testing tool".

The test base framework is Minitest.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'osatest'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install osatest

## Usage

~~~ruby
require 'osatest'

class MyTest < Minitest::Test

  def test_my_first_test

    resume "
    It's a simple test to check the Terminal output.
    "

    synopsis "
    - open a new Terminal window,
    - type 'ls -la'
    - check the output
    "

    tosa = OSATest.new(app: "Terminal", delay: 1)
    action "I open a new Terminal window"
    tosa.new_window

    action "I'm going to root"
    tosa << ['cd /Users', :RETURN]

    action "I type 'ls -la and stroke return key"
    tosa << ["ls -la", :RETURN]
    
    action "I check the output"
    tosa.has_in_last_lines("philippeperret")
  
  end

end
~~~

### Item in a select menu

Note you can't ask *Osatest* to find out a item in a select menu by giving it the content of the menu (during the development, the index of the item can change). You have to deal with that in the test itself, loading the choices of the select and finding the index of the menu itself.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/osatest.

