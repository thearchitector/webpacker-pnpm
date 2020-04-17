require "rails/railtie"

module Webpacker
	module PNPM
		class Railtie < Rails::Railtie
			rake_tasks do
				# load all the rake tasks within the `tasks` directory
				Dir[File.join(File.dirname(__FILE__),'internal/lib/tasks/**/*.rake')].each do |task|
					load task
				end
			end
		end
	end
end