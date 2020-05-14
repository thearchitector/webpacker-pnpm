# frozen_string_literal: true

require "rails"
require "rails/test_help"
require "etc"
require "fileutils"
require "open3"

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
      Minitest.parallel_executor = Minitest::Parallel::Executor.new(Etc.nprocessors)
      parallelize_me!

      protected

      # concurrent scoped chdir calls are not supported, as they can cause
      # unforeseen and unpredictable bugs. instead, allow copying the desired
      # directory to a temp directory before performing possible filesystem
      # manipulations. opts are passed through to Open3::capture2e
      def chdir_concurrent(dir, cmd, env = {}, opts = {})
        # Process::spawn requires an env hash of strings
        env.stringify_keys!
        env.transform_values!(&:to_s)

        env = ENV.to_h.merge(env)
        isolated = opts.delete(:isolated)
        output = nil

        begin
          # if we're want an isolated environment, copy the directory contents to
          # a new temporary directory and change the working directory to it
          if isolated
            files = Dir[File.join(dir, "*")].reject do |f|
              f.include?("node_modules")
            end

            dir = Dir.mktmpdir
            FileUtils.cp_r(files, dir)
          end

          output, = Open3.capture2e(env, "cd #{dir} && #{cmd}", opts)
          yield(output, dir) if block_given?
        ensure
          # make sure we remove the generated temp directory
          FileUtils.remove_entry_secure(dir) if isolated
        end

        output
      end
    end
  end
end
