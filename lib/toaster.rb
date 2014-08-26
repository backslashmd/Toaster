module Toaster
	def self.included(base)
		base.extend ClassMethods
	end

	module ClassMethods
		def toast(*args)
			options = args.extract_options!
			options[:on] = :update
			validates_with PasswordValidator, options
		end
	end

	class PasswordValidator < ActiveModel::Validator
		def validate(record)
			default_options = { password_field: :password, label: "Password", min_uppercase: 0, min_lowercase: 0, min_length: 8, min_numeric: 0, min_alpha: 0, min_punctuation: 0, exclude: "", decrypt: Proc.new{ |pwd| pwd } }
			opts = default_options.merge options
			field_name = opts[:label].nil? ? opts[:password_field].to_s.humanize : opts[:label].to_s
			field_value = opts[:decrypt].call(record[opts[:password_field]])
			record.errors[field_name] << I18n.t("toaster.error.min_length", min: opts[:min_length]) if field_value.length < opts[:min_length]
			record.errors[field_name] << I18n.t("toaster.error.min_numeric", min: opts[:min_numeric]) if field_value.count("0-9") < opts[:min_numeric]
			record.errors[field_name] << I18n.t("toaster.error.min_alpha", min: opts[:min_alpha]) if field_value.count("A-Za-z") < opts[:min_alpha]
			record.errors[field_name] << I18n.t("toaster.error.min_punctuation", min: opts[:min_punctuation]) if field_value.count("^A-Za-z0-9 ") < opts[:min_punctuation]
			record.errors[field_name] << I18n.t("toaster.error.min_uppercase", min: opts[:min_uppercase]) if field_value.count("A-Z") < opts[:min_uppercase]
			record.errors[field_name] << I18n.t("toaster.error.min_lowercase", min: opts[:min_lowercase]) if field_value.count("a-z") < opts[:min_lowercase]
			record.errors[field_name] << I18n.t("toaster.error.invalid_characters", characters: opts[:exclude].chars.join(" ")) if field_value.count(opts[:exclude]) > 0
		end
	end
end

class ActiveRecord::Base
	include Toaster
end