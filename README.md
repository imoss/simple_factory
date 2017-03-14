# SimpleFactory

A simple helper for creating basic factory methods within a ruby class

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'simple_factory', git: 'https://github.com/imoss/simple_factory'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install simple_factory -s https://github.com/imoss/simple_factory

## Usage

It can be helpful in your business objects to define a class method that acts as a factory for that class. For example, let's say you have a class called `UserKeyGenerator` which is designed to generate a key (String) and assign it to a User:

```ruby
class User
  attr_accessor :key
end

class UserKeyGenerator
  def initialize(user, length)
    @user, @length = user, length
  end

  def generate
    @user.key = "user_#{SecureRandom.hex(length)}"
  end
end

some_user = User.new
```

The code above defines the API for `UserKeyGenerator` as the following:

`UserKeyGenerator.new(some_user, 5).generate`

In the interest of creating a cleaner and more concise API for `UserKeyGenerator` we could define a class method that acts as a factory of that class and in turn calls the corresponding instance method:

```ruby
class UserKeyGenerator
  def initialize(user, length)
    @user, @length = user, length
  end

  def self.generate(user, length)
    new(user, length).generate
  end

  def generate
    @user.key = "user_#{SecureRandom.hex(length)}"
  end
end
```

This yeilds us a much cleaner and more concise interface for using `UserKeyGenerator` while still affording us all the power of a ruby object instance:

`UserKeyGenerator.generate(some_user, 5)`

This is where `simple_factory` comes in...

By requiring `SimpleFactory` in your business object, you give that object access to the `simple_factory` method which creates the class level interface for your instance methods. Just pass the instance method name to `simple_factory` as a symbol:

```ruby
class UserKeyGenerator
  include SimpleFactory

  simple_factory :generate

  def initialize(user, length)
    @user, @length = user, length
  end

  def generate
    @user.key = "user_#{SecureRandom.hex(length)}"
  end
end
```

The code above dynamically creates a class method called `generate` in `UserKeyGenerator` that takes the same arguements as the initializer. Thus the interface remains the same as in the previous example:

`UserKeyGenerator.generate(some_user, 5)`

The `simple_factory` method can also take multiple arguements: 

```ruby
class UserKeyGenerator
  include SimpleFactory

  simple_factory :generate, :foo, :bar

  def initialize(user, length)
    @user, @length = user, length
  end

  def generate
    @user.key = "user_#{SecureRandom.hex(length)}"
  end

  def foo
    # do stuff
  end

  def bar
   # do stuff
  end
end
```

This can be very handy for business objects with a lot of specialized behavior that would benefit from a class level interface but want to make use of all of the power of a ruby object instance (eg. getters, setters, initializers, etc.)

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/imoss/simple_factory. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

