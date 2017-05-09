# HashMangler

Just a simple gem which converts nested hash into a struct allowing to access data with method calls like:
```
  mangled_hash.users[0].name # => John
```
instead of doing:
```
  users_hash[:users][0].fetch(:name)
```
for a hash:
```
  {
    users: [
      { name: 'John' }
    ]
  }
```

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'hash_mangler'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install hash_mangler

## Usage


## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/smnkrt/hash_mangler.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
