# frozen_string_literal: true

require "test_helper"

module Webpacker
  module PNPM
    class RakeTasksTest < Test
      def test_rake_tasks
        output = chdir_cmd(test_app_path, "bundle exec rake --tasks")
        assert_not_includes output, "webpacker:check_yarn"
        assert_not_includes output, "webpacker:yarn_install"
        assert_not_includes output, "yarn:install"
        assert_includes output, "webpacker"
        assert_includes output, "webpacker:binstubs"
        assert_includes output, "webpacker:check_binstubs"
        assert_includes output, "webpacker:check_node"
        assert_includes output, "webpacker:check_pnpm"
        assert_includes output, "webpacker:clean"
        assert_includes output, "webpacker:clobber"
        assert_includes output, "webpacker:compile"
        assert_includes output, "webpacker:info"
        assert_includes output, "webpacker:install"
        assert_includes output, "webpacker:install:angular"
        assert_includes output, "webpacker:install:coffee"
        assert_includes output, "webpacker:install:elm"
        assert_includes output, "webpacker:install:erb"
        assert_includes output, "webpacker:install:react"
        assert_includes output, "webpacker:install:svelte"
        assert_includes output, "webpacker:install:stimulus"
        assert_includes output, "webpacker:install:typescript"
        assert_includes output, "webpacker:install:vue"
        assert_includes output, "webpacker:pnpm_install"
        assert_includes output, "webpacker:verify_install"
      end

      def test_check_binstubs
        output = chdir_cmd(test_app_path, "rake webpacker:check_binstubs 2>&1")
        assert_not_includes output, "Webpack binstubs not found."
      end

      def test_check_node_version
        output = chdir_cmd(test_app_path, "rake webpacker:check_node 2>&1")
        assert_not_includes output, "Node.js is not installed"
        assert_not_includes output, "Webpacker requires Node.js"
      end

      def test_check_pnpm_version
        output = chdir_cmd(test_app_path, "rake webpacker:check_pnpm 2>&1")
        assert_not_includes output, "pnpm is not installed"
        assert_not_includes output, "Webpacker requires pnpm"
      end

      # cannot be different methods since they cannot run in parallel
      # (they both modify the working directory and would cause race conditions)
      #
      # TODO: figure out a nice way to avoid doing putting everything in the same
      # method
      def test_rake_webpacker_pnpm_install_in_environments
        assert_includes test_app_dev_dependencies, "right-pad"

        Webpacker.with_node_env("test") do
          chdir_cmd(test_app_path, "bundle exec rake webpacker:pnpm_install")
        end

        assert_includes installed_node_module_names, "right-pad", "Expected dev dependencies to be installed"

        Webpacker.with_node_env("production") do
          chdir_cmd(test_app_path, "bundle exec rake webpacker:pnpm_install")
        end

        assert_not_includes installed_node_module_names, "right-pad", "Expected only production dependencies to be installed"
      end

      private

      def test_app_path
        File.expand_path("test_app", __dir__)
      end

      def test_app_dev_dependencies
        package_json = File.expand_path("package.json", test_app_path)
        JSON.parse(File.read(package_json))["devDependencies"]
      end

      def installed_node_module_names
        node_modules_path = File.expand_path("node_modules", test_app_path)
        Dir.children(node_modules_path)
      end
    end
  end
end
