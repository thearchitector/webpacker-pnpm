# frozen_string_literal: true

require "rails/railtie"

module Webpacker
  module PNPM
    class Railtie < Rails::Railtie
      private

      rake_tasks do
        # load all the rake tasks within the `tasks` directory
        Dir[File.join(File.dirname(__FILE__), "../tasks/**/*.rake")].each do |task|
          load task
        end
      end

      # manually specify bin path to skip Yarn execution during Webpack runner
      # initialization
      config.before_configuration do
        ENV["WEBPACKER_NODE_MODULES_BIN_PATH"] ||= File.join(`pnpm root`.chomp, ".bin")
      end
    end
  end
end
