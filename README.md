# HashMangler
[![Gem Version](https://badge.fury.io/rb/hash_mangler.svg)](https://badge.fury.io/rb/hash_mangler)

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
options = { value_mangler: value_mangler }
hm = HashMangler::Mangler.new(options).mangle(hash)
hm.some_method_name
```


By default method names are in snake case, to leave them the same as input hash keys:

```
snake_case_method_names: false
```

option needs to be passed into `initialize` like:

```
options = { snake_case_method_names: false } 
hm = HashMangler::Mangler.new(options).mangle(hash)
hm.someMethodName
```

Hash can also be mangled with `OpenStruct` or `Hash` using `struct_class` option:

```
options = { struct_class: OpenStruct }
hm = HashMangler::Mangler.new(options).mangle(hash)
hm.some_method_name
```

`HashMangler::SimpleStruct` can also be used instead of `OpenStruct` when using:

```
JSON.parse(json, object_class: OpenStruct)
```

This way a `NoMethodError` will be raised instead of returning `nil` when method name does not comply with


## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/smnkrt/hash_mangler.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
