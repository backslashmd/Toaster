require 'rails/generators/base'
require 'rails/generators/actions'
require 'fileutils'

module Toaster
	module Generators
		class ToasterGenerator < Rails::Generators::Base

			source_root File.expand_path("templates", File.dirname(__FILE__))

			def copy_locale
				copy_file "locales/toaster.yml", "config/locales/toaster.en.yml"
			end

			def copy_initializer
				copy_file "initializers/toaster.rb", "config/initilaizers/toaster.rb"
			end
		end
	end
end