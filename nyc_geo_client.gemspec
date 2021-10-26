# -*- encoding: utf-8 -*-
require File.expand_path('../lib/nyc_geo_client/version', __FILE__)

Gem::Specification.new do |gem|
  gem.add_development_dependency 'rake'
  gem.add_development_dependency('rspec', '~> 3.10.0')
  gem.add_development_dependency('webmock', '~> 3.14.0')
  gem.add_development_dependency('yard', '~> 0.9.26')

  gem.add_runtime_dependency('faraday', '~> 1.7.2')
  gem.add_runtime_dependency('faraday_middleware', '~> 1.1.0')
  gem.add_runtime_dependency('multi_json', '~> 1.15.0')
  gem.add_runtime_dependency('multi_xml', '~> 0.6.0')
  gem.add_runtime_dependency('hashie',  '~> 4.1.0')
  gem.authors       = ["Edgar Gonzalez"]
  gem.email         = ["edgargonzalez@gmail.com"]
  gem.description   = %q{A ruby wrapper for NYCGeoClient API}
  gem.homepage      = "http://github.com/edgar/NYCGeoClient"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.summary       = %q{A ruby wrapper for NYCGeoClient API}
  gem.name          = "nyc_geo_client"
  gem.require_paths = ["lib"]
  gem.version       = NYCGeoClient::VERSION.dup
end
