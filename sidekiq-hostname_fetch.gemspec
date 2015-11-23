# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'sidekiq/hostname_fetch/version'

Gem::Specification.new do |spec|
  spec.name          = "sidekiq-hostname_fetch"
  spec.version       = Sidekiq::HostnameFetch::VERSION
  spec.authors       = ["Kir Shatrov"]
  spec.email         = ["shatrov@me.com"]
  spec.description   = %q{Write a gem description}
  spec.summary       = %q{Write a gem summary}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency 'sidekiq', '>= 2.6.5', '< 5'

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency "rake"
end
