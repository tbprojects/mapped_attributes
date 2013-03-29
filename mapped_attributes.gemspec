# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'mapped_attributes/version'

Gem::Specification.new do |gem|
  gem.name          = "mapped_attributes"
  gem.version       = MappedAttributes::VERSION
  gem.authors       = ["Tomasz Borowski [tbprojects]"]
  gem.email         = 'info.tbprojects@gmail.com'
  gem.description   = "This gem allows to build ActiveRecord objects with alternative attribute naming"
  gem.summary       = "This gem allows to build ActiveRecord objects with alternative attribute naming"
  gem.homepage      = "https://github.com/tbprojects/mapped_attributes"

  gem.files         = `git ls-files`.split("\n")
  gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.require_paths = ["lib"]

  gem.add_development_dependency 'rake'
  gem.add_runtime_dependency 'activerecord'
  gem.add_runtime_dependency 'i18n'
end