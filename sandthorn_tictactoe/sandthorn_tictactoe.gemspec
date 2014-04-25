# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'sandthorn_tictactoe/version'

Gem::Specification.new do |spec|
  spec.name          = "sandthorn_tictactoe"
  spec.version       = TicTacToe::VERSION
  spec.authors       = ["Marcus Ljungblad"]
  spec.email         = ["marcus.ljungblad@upptec.se"]
  spec.summary       = "An implementation of TicTacToe using Event Sourcing based on Sandthorn"
  spec.description   = "TODO: include readme here"
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "sandthorn"
  spec.add_development_dependency "sqlite3"
  spec.add_development_dependency "sandthorn_driver_sequel", "~> 1.1"
end
