# -*- encoding: utf-8 -*-
require File.expand_path("../lib/serveable/version", __FILE__)

Gem::Specification.new do |s|
  s.name         = "serveable"
  s.author       = "Joshua Hawxwell"
  s.email        = "m@hawx.me"
  s.summary      = "Minimal fuss rack server hooks."
  s.homepage     = "http://github.com/hawx/serveable"
  s.version      = Serveable::VERSION

  s.description  = <<-DESC
    Provides a module that allow you to easily incorporate a simple
    'server -> site -> page' model on top of rack.
  DESC

  s.files        = %w(README.md Rakefile LICENSE)
  s.files       += Dir["{lib,spec}/**/*"] & `git ls-files`.split("\n")
  s.test_files   = Dir["{spec}/**/*"] & `git ls-files`.split("\n")
end
