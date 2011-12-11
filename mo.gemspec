# encoding: utf-8

$:.unshift File.expand_path('../lib', __FILE__)
require 'mo/version'

Gem::Specification.new do |s|
  s.name         = "mo"
  s.version      = Mo::VERSION
  s.authors      = ["chatgris"]
  s.email        = "jboyer@af83.com"
  s.homepage     = "https://github.com/chatgris/mo"
  s.summary      = "[Mo helps you keep your rails project clean.]"
  s.description  = "[Mo helps you keep your rails project clean.]"

  s.files        = `git ls-files app lib`.split("\n")
  s.platform     = Gem::Platform::RUBY
  s.require_path = 'lib'
end
