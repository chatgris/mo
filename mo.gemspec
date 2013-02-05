# encoding: utf-8

$:.unshift File.expand_path('../lib', __FILE__)
require 'mo/version'

Gem::Specification.new do |s|
  s.name         = "mo"
  s.version      = Mo::VERSION
  s.authors      = ["chatgris"]
  s.email        = "jboyer@af83.com"
  s.homepage     = "http://chatgris.github.com/mo/"
  s.summary      = "Mo helps you keep your rails project clean."
  s.description  = "Mo helps you keep your rails project clean."
  s.files        = `git ls-files bin lib LICENSE README.md`.split("\n")
  s.platform     = Gem::Platform::RUBY
  s.require_path = 'lib'
  s.executables  = s.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  s.add_dependency 'boson'
  s.add_development_dependency 'rake'
  s.add_development_dependency 'minitest'
end
