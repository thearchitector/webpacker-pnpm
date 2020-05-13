# frozen_string_literal: true

require "test_helper"

module Webpacker
  module PNPM
    class RakeTasksTest < Test
      def test_rake_tasks
        output = chdir_concurrent(test_path, "bundle exec rake --tasks")
        assert_includes output, "webpacker"
        assert_includes output, "webpacker:binstubs"
        assert_includes output, "webpacker:check_binstubs"
        assert_includes output, "webpacker:check_node"
        assert_includes output, "webpacker:check_pnpm"
        assert_includes output, "webpacker:clean"
        assert_includes output, "webpacker:clobber"
        assert_includes output, "webpacker:compile"
        assert_includes output, "webpacker:env"
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

        assert_not_includes output, "webpacker:check_yarn"
        assert_not_includes output, "webpacker:yarn_install"
        assert_not_includes output, "yarn:install"
      end

      def test_check_pnpm_version
        output = chdir_concurrent(test_path, "rake webpacker:check_pnpm 2>&1")
        assert_not_includes output, "pnpm is not installed"
        assert_not_includes output, "Webpacker requires pnpm"

        assert_includes output, "Verifying pnpm version..."
      end

      def test_override_check_yarn_version
        output = chdir_concurrent(test_path, "rake webpacker:check_yarn 2>&1")
        assert_not_includes output, "pnpm is not installed"
        assert_not_includes output, "Webpacker requires pnpm"

        assert_includes output, "Verifying pnpm version..."
      end

      def test_pnpm_install_in_production_env
        cmd = "bundle exec rake webpacker:pnpm_install"

        chdir_concurrent(test_path, cmd, { NODE_ENV: :production }, { isolated: true }) do |_, temp|
          assert_not_includes installed_node_modules(temp), "right-pad", "Expected only production dependencies to be installed"
        end
      end

      def test_pnpm_install_in_test_env
        assert_includes test_app_dev_dependencies, "right-pad"

        cmd = "bundle exec rake webpacker:pnpm_install"

        chdir_concurrent(test_path, cmd, { NODE_ENV: :test }, { isolated: true }) do |_, temp|
          assert_includes installed_node_modules(temp), "right-pad", "Expected dev dependencies to be installed"
        end
      end

      def test_yarn_install_alias_in_production_env
        cmd = "bundle exec rake webpacker:yarn_install"

        chdir_concurrent(test_path, cmd, { NODE_ENV: :production }, { isolated: true }) do |_, temp|
          assert_not_includes installed_node_modules(temp), "right-pad", "Expected only production dependencies to be installed"
        end
      end

      def test_yarn_install_alias_in_test_env
        assert_includes test_app_dev_dependencies, "right-pad"

        cmd = "bundle exec rake webpacker:yarn_install"

        chdir_concurrent(test_path, cmd, { NODE_ENV: :test }, { isolated: true }) do |_, temp|
          assert_includes installed_node_modules(temp), "right-pad", "Expected dev dependencies to be installed"
        end
      end

      private

      def test_path
        File.expand_path("test_app", __dir__)
      end

      def test_app_dev_dependencies
        package_json = File.expand_path("package.json", test_path)
        JSON.parse(File.read(package_json))["devDependencies"]
      end

      def installed_node_modules(dir)
        node_modules_path = File.expand_path("node_modules", dir)
        Dir.children(node_modules_path)
      end
    end
  end
end
