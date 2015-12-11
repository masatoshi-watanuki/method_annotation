# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'method_annotation/version'

Gem::Specification.new do |spec|
  spec.name          = "method_annotation"
  spec.version       = MethodAnnotation::VERSION
  spec.authors       = ["masatoshi-watanuki"]
  spec.email         = ["masatoshi.watanuki@gmail.com"]

  spec.summary       = 'method annotation'
  spec.description   = 'method annotation'
  spec.homepage      = "https://github.com/masatoshi-watanuki/gems/tree/master/method_annotation"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.required_ruby_version = Gem::Requirement.create('~> 2.2.1')

  #if spec.respond_to?(:metadata)
  #  spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com' to prevent pushes to rubygems.org, or delete to allow pushes to any server."
  #end

  spec.add_development_dependency "bundler", "~> 1.9"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"

  # add
  spec.add_dependency "activesupport", "~> 4.2.3"
end
