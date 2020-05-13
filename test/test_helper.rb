# frozen_string_literal: true

require "rails"
require "rails/test_help"
require "byebug"
require "etc"

require_relative "test_app/config/environment"

Rails.env = "production"

Webpacker.instance = ::Webpacker::Instance.new

module Webpacker
  module PNPM
    class Test < ActiveSupport::TestCase
      # force test parallelization - this is not about test speed, it is about
      # maximizing the likelihood of having tests fail by providing isolated
      # execution threads. manually specify the number of workers, as by default
      # Rails uses the number of physical, not logical, cores. Additionally,
      # spawn threads rather than fork processes as Rails' DRb implementation
      # only supports UNIX systems
      parallelize(workers: Etc.nprocessors, with: :threads)

      private

      # concurrent scoped chdir calls are not supported, as they
      # can cause unforeseen and unpredictable bugs. instead, use
      # interpolated backticks, as they spawn sub-processes and thus
      # are effectively scoped
      def chdir_cmd(dir, cmd)
        `cd #{dir} && #{cmd}`
      end
    end
  end
end
