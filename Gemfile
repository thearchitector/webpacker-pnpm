# frozen_string_literal: true

source "https://rubygems.org"
gemspec

gem "rails"
gem "rake", ">= 11.1"
gem "rack-proxy", require: false
gem "semantic_range", require: false

install_if -> { Gem.win_platform? } do
	gem "tzinfo-data"
end

group :test do
	gem "minitest", "~> 5.0"
	gem "byebug"
end
