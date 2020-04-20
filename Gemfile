# frozen_string_literal: true

source "https://rubygems.org"
gemspec

gem "rack-proxy", require: false
gem "rails", ">= 5.2"
gem "rake", ">= 12.3.3"
gem "semantic_range", require: false

install_if -> { Gem.win_platform? } do
  gem "tzinfo-data"
end

group :test do
  gem "byebug"
  gem "minitest", ">= 5"
end
