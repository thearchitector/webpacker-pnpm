# frozen_string_literal: true

require "action_controller/railtie"
require "action_view/railtie"
require "webpacker"
require "webpacker/pnpm"

module TestApp
  class Application < ::Rails::Application
    config.secret_key_base = "abcdef"
    config.eager_load = true
  end
end
