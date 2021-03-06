# frozen_string_literal: true

require "webpacker/version"

namespace :webpacker do
  desc "Provide information on Webpacker's current environment"
  task env: [:environment] do
    $stdout.puts "Ruby: #{`ruby --version`}"
    $stdout.puts "Rails: #{Rails.version}"
    $stdout.puts "Webpacker: #{Webpacker::VERSION}"
    $stdout.puts "Node: #{`node --version`}"
    $stdout.puts "pnpm: #{`pnpm --version`}"

    $stdout.puts "\n"
    $stdout.puts "@rails/webpacker: \n#{`npm list @rails/webpacker version`}"

    $stdout.puts "Is bin/webpack present?: #{File.exist?("bin/webpack")}"
    $stdout.puts <<~HEREDOC.squish
      Is bin/webpack-dev-server present?: #{File.exist?("bin/webpack-dev-server")}
    HEREDOC
  end
end
