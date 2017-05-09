# HashMangler

Just a simple gem which converts nested hash into a struct allowing to access data with method calls like:
```
  mangled_hash.users[0].name # => John
```
instead of doing:
```
  users_hash[:users][0].fetch(:name) # => John
```
for a hash:
```
  users_hash = {
    users: [
      { name: 'John' }
    ]
  }
```

Gem converts hash key names to snake case and in case of misspelled names is raising NoMethodError

## Installation

For now it's only on Github, but after it's published on rubygems installation would look like this:

Add this line to your application's Gemfile:

```ruby
gem 'hash_mangler'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install hash_mangler

## Usage

`HashMangler::Mangler.new.mangle(hash)`

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/smnkrt/hash_mangler.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
