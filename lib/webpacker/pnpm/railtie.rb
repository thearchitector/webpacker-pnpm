# frozen_string_literal: true

require "rails/railtie"

module Webpacker
  module PNPM
    class Railtie < Rails::Railtie
      rake_tasks do
        # load all the rake tasks within the `tasks` directory
        Dir[File.join(File.dirname(__FILE__), "../tasks/**/*.rake")].each do |task|
          load task
        end
      end

      # manually specify node_modules bin path to skip Yarn execution during
      # Webpack runner initialization
      config.before_configuration do
        begin
          ENV["WEBPACKER_NODE_MODULES_BIN_PATH"] ||= File.join(`pnpm root`.chomp, ".bin")
        rescue Errno::ENOENT
          # use abort instead of Rails' logger because it doesn't show up when
          # run within Rake tasks
          abort(
            <<~HEREDOC.squish
              \e[31m[FATAL] pnpm is not installed or not present in $PATH.
              Install pnpm and try again.\e[0m
            HEREDOC
          )
        end
      end
    end
  end
end
