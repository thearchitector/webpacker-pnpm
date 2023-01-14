# frozen_string_literal: true

require "rails/generators"
require "webpacker/runner"
require "webpacker/compiler"
require "webpacker/webpack_runner"

module Webpacker
  module PNPM
    # remove Yarn's lockfile from and add pnpm's lockfile to the default list of
    # watched paths
    Webpacker::Compiler.class_eval do
      def default_watched_paths
        [
          *configured_paths,
          config.source_path_globbed,
          "pnpm-lock.yaml", "package.json",
          "config/webpack/**/*"
        ].freeze
      end

      def configured_paths
        if config.respond_to?(:additional_paths_globbed)
          config.additional_paths_globbed
        else
          config.resolved_paths_globbed
        end
      end
    end

    Webpacker::WebpackRunner.class_eval do
      def run
        env = Webpacker::Compiler.env
        env["WEBPACKER_CONFIG"] = @webpacker_config

        cmd = if node_modules_bin_exist?
                ["#{@node_modules_bin_path}/webpack"]
              else
                ["pnpm", "webpack"]
              end

        cmd = ["node", "--inspect-brk"] + cmd if @argv.include?("--debug-webpacker")

        cmd += ["--config", @webpack_config] + @argv

        Dir.chdir(@app_path) do
          Kernel.exec(env, *cmd)
        end
      end
    end

    # intercept command execution via Thor to replace yarn with pnpm. this exists in
    # order to patch existing Webpacker installation templates that make direct
    # calls to install Yarn dependencies. as a result, this isn't a robust patch
    Rails::Generators::Actions.module_eval do
      def run(command, config = {})
        cmd = command.to_s

        if cmd.include?("yarn")
          cmd.gsub!("yarn", "pnpm")
          cmd.gsub!("--dev", "--save-dev")
        end

        super(cmd, config)
      end
    end

    # intercept generic task loading to clear and alias Yarn tasks
    Rails::Engine.class_eval do
      alias_method :unfiltered_tasks, :load_tasks

      def load_tasks(_app = self)
        unfiltered_tasks
        # rather than clear the tasks, alias them to the new pnpm tasks so
        # that any external code will still run
        Rake::Task["webpacker:check_yarn"].clear.enhance(["webpacker:check_pnpm"])
        Rake::Task["webpacker:yarn_install"].clear.enhance(["webpacker:pnpm_install"])
        Rake::Task["webpacker:info"].clear.enhance(["webpacker:env"])
        Rake::Task["yarn:install"].clear.enhance(["webpacker:pnpm_install"])
      end
    end
  end
end
