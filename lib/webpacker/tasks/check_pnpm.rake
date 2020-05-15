# frozen_string_literal: true

require "semantic_range"

namespace :webpacker do
  desc "Verifies if pnpm is installed"
  task check_pnpm: [:environment] do
    begin
      $stdout.puts "Verifying pnpm version..."

      pnpm_version = `pnpm --version`.chomp
      raise Errno::ENOENT if pnpm_version.blank?

      pnpm_range = ">=3.0.0"
      is_unsupported = SemanticRange.satisfies?(pnpm_version, pnpm_range) rescue false

      unless is_unsupported
        warn "Webpacker requires pnpm \"#{pnpm_range}\" and you are using #{pnpm_version}. Please upgrade pnpm https://pnpm.js.org/en/installation/"
        warn "Exiting!"
        exit!
      end
    rescue Errno::ENOENT
      warn "pnpm is not installed. Please download and install pnpm from https://pnpm.js.org/en/installation/"
      warn "Exiting!"
      exit!
    end
  end
end
