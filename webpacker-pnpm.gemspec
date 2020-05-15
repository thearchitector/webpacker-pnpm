# frozen_string_literal: true

lib = File.expand_path("lib", __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "webpacker/pnpm/version"

Gem::Specification.new do |spec|
  spec.name        = "webpacker-pnpm"
  spec.version     = Webpacker::PNPM::VERSION
  spec.author      = "Elias Gabriel"
  spec.email       = "me@eliasfgabriel.com"
  spec.summary     = "Replaces Webpacker's Yarn environment with pnpm."
  spec.description = "webpacker-pnpm minimizes dependency hell, improves code quality and stability, and reduces node_modules folder sizes by replacing Webpacker's Yarn environment with pnpm."
  spec.homepage    = "https://github.com/thearchitector/webpacker-pnpm"
  spec.license     = "CC-BY-NC-SA-4.0"

  spec.metadata    = {
    "homepage_uri" => spec.homepage,
    "source_code_uri" => "#{spec.homepage}/tree/v#{spec.version}",
    "changelog_uri" => "#{spec.homepage}/blob/v#{spec.version}/CHANGELOG.md",
    "bug_tracker_uri" => "#{spec.homepage}/issues"
  }

  spec.required_ruby_version = ">= 2.4.0"

  spec.add_dependency "rails", ">= 5.2"
  spec.add_dependency "rake", ">= 12.3.3"
  spec.add_dependency "semantic_range", "~> 2.3"
  spec.add_dependency "webpacker", "~> 5.0"

  spec.add_development_dependency "minitest", "~> 5.0"
  spec.add_development_dependency "rubocop", "~> 0.83.0"
  spec.add_development_dependency "rubocop-minitest", "~> 0.9"
  spec.add_development_dependency "rubocop-performance", "~> 1.3"
  spec.add_development_dependency "rubocop-rails", "~> 2.5"

  spec.files       = `git ls-files`.split("\n")
  spec.test_files  = `git ls-files -- test/*`.split("\n")
end
