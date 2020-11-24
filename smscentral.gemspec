# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'smscentral/version'
require 'smscentral/api_version'

Gem::Specification.new do |spec|
  spec.name          = 'smscentral'
  spec.version       = Smscentral::VERSION
  spec.authors       = ['Peter Fern']
  spec.email         = ['support@noojeeit.com.au']

  spec.summary       = "REST client for smscentral.com.au API #{Smscentral::API_VERSION}"
  spec.homepage      = 'https://bitbucket.org/noojee/ruby-smscentral'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.12'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_dependency 'rest-client', '>= 2.0.0'
end
