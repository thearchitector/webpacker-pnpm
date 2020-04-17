# frozen_string_literal: true

lib = File.expand_path("lib", __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "webpacker/pnpm/version"

Gem::Specification.new do |spec|
  spec.name        = "webpacker-pnpm"
  spec.version     = Webpacker::PNPM::VERSION
  spec.authors     = [ "Elias Gabriel" ]
  spec.email       = [ "me@eliasfgabriel.com" ]
  spec.summary     = "Use pnpm with Webpacker instead of Yarn"
  spec.description = "Replaces Yarn's webpacker integration with a pnpm environment."
  spec.homepage    = "https://github.com/thearchitector/webpacker-pnpm"
  spec.license     = "CC-BY-NC-SA-4.0"

  spec.metadata    = {
    "homepage_uri" => spec.homepage,
    "source_code_uri" => "https://github.com/thearchitector/webpacker-pnpm/tree/v#{Webpacker::PNPM::VERSION}",
    "changelog_uri" => "https://github.com/thearchitector/webpacker-pnpm/blob/v#{Webpacker::PNPM::VERSION}/CHANGELOG.md"
  }

  spec.required_ruby_version = ">= 2.4.0"

  spec.add_dependency "webpacker", "~> 5.x"
  spec.add_dependency "semantic_range", ">= 2.3.0"
  spec.add_dependency "railties",      ">= 5.2"

  spec.add_development_dependency "bundler", "~> 2.0"
  spec.add_development_dependency "rake", ">= 12.3.3"
  spec.add_development_dependency "rubocop", "< 0.69"
  spec.add_development_dependency "rubocop-performance"

  spec.files       = `git ls-files`.split("\n")
  spec.test_files  = `git ls-files -- test/*`.split("\n")
end
