# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'bbr/version'

Gem::Specification.new do |spec|
  spec.name          = "bbr"
  spec.version       = Bbr::VERSION
  spec.authors       = ["Jesper Sørensen & Nicolai Seerup"]
  spec.email         = ["admin@abtion.com"]

  spec.summary       = %q{Ruby wrapper around BBR registerets SOAP API}
  spec.description   = %q{Use to pull data from BBR registeret concerning house properties in Denmark. You have to sign up at : https://www.conzoom.eu/ to get at username and password}
  spec.homepage      = "https://github.com/abtion/bbr"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency 'nokogiri', '~> 1.6.6.2'
  spec.add_development_dependency 'dotenv'
  spec.add_development_dependency 'activesupport'
end
