#!/usr/bin/env rake
require 'rubygems'
require 'rake'
require 'echoe'

Echoe.new('toaster', '0.1.0') do |p|
	p.description = "Password validation."
	p.url = "http://www.commercekitchen.com"
	p.author = "Commerce Kitchen"
	p.email = "eric@commercekitchen.com"
	p.ignore_pattern = ["tmp/*", "script/*"]
end

Dir.glob("#{File.dirname(__FILE__)}/lib/locales/*.{rb,yml}")

Dir["#{File.dirname(__FILE__)}/tasks/*.rake"].sort.each{ |ext| load ext }
