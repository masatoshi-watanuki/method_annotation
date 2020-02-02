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
  spec.description   = <<-EOS
MethodAnnotation You can define the annotation function method. 
Note translation function can also be added simply tagged to only cross-processing from applications.
  EOS
  spec.homepage      = "https://github.com/masatoshi-watanuki/method_annotation"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.required_ruby_version = Gem::Requirement.create('~> 2.7.0')
  spec.licenses = ['MIT']

  spec.add_development_dependency "bundler", "~> 2.1"
  spec.add_development_dependency "rake", "~> 13.0"
  spec.add_development_dependency "rspec", "~> 3.9.0"

  # add
  spec.add_dependency "activesupport", "~> 6.0.2"
end
