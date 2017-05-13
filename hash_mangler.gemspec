# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'hash_mangler/version'

Gem::Specification.new do |spec|
  spec.name          = "hash_mangler"
  spec.version       = HashMangler::VERSION
  spec.authors       = ["smnkrt"]
  spec.email         = ["skrt12@gmail.com"]
  spec.homepage      = "https://github.com/smnkrt/hash_mangler"

  spec.summary       = %q{Simple Hash mapper.}
  spec.description   = %q{Converts nested Hashes into a nested struct}
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.14"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "pry"
end
