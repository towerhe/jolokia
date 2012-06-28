# -*- encoding: utf-8 -*-
require File.expand_path('../lib/jolokia/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ['Tower He']
  gem.email         = ['towerhe@gmail.com']
  gem.description   = %q{The Jolokia ruby library }
  gem.summary       = %q{The Jolokia ruby library provides a ruby API to the to the Jolokia agent. }
  gem.homepage      = 'https://github.com/towerhe/jolokia'

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = 'jolokia'
  gem.require_paths = ['lib']
  gem.version       = Jolokia::VERSION

  gem.add_dependency 'virtus', '~> 0.5.1'
  gem.add_dependency 'faraday', '~> 0.8.1'
  gem.add_dependency 'faraday_middleware', '~> 0.8.8'
  gem.add_dependency 'oj', '~> 1.2.11'
end
