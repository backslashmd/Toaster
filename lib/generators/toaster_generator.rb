require 'rails/generators/base'
require 'rails/generators/actions'
require 'fileutils'

module Toaster
	module Generators
		class ToasterGenerator < Rails::Generators::Base
			def copy_initializer
				unless File.exist?(File.expand_path("config/locales/toaster.en.yml", Rails.root))
					copy_file "locales/toaster.yml", "config/locales/toaster.yml"
				end
			end
		end
	end
end