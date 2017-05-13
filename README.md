# HashMangler

A simple gem which converts nested hash into a struct allowing data access with method calls like:
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

Gem converts hash key names to snake case and in case of misspelled names is raising NoMethodError.

## Installation

Add this line to your application's Gemfile:

```
gem 'hash_mangler'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install hash_mangler

## Usage

For a basic convertion from Hash to a nested object:
```
hm = HashMangler::Mangler.new.mangle(hash)
hm.some_method_name
```

You can also perform operations on argument hash values by passing a proc to the `initialize` method:
```
value_mangler = proc { |o| o.to_s.downcase }  
hm = HashMangler::Mangler.new(value_mangler: value_mangler).mangle(hash)
hm.some_method_name
```

If you want you can use `HashMangler::SimpleStruct` instead of `OpenStruct` when using `JSON.parse(json, object_class: OpenStruct)`. This way a `NoMethodError` will be raised instead of returning `nil` when method name does not comply with

By default method names are in snake case, to leave them the same as input hash keys `snake_case_method_names: false` option needs to be passed into `initialize`:
```
hm = HashMangler::Mangler.new(snake_case_method_names: false).mangle(hash)
hm.someMethodName
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/smnkrt/hash_mangler.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
