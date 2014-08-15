module Toaster
	def self.included(base)
		base.extend ClassMethods
	end

	module ClassMethods
		def toast(*args)
			options = args.extract_options!
			validates_with PasswordValidator, options
		end
	end

	class PasswordValidator < ActiveModel::Validator
		def validate(record)
			default_options = { password_field: :password, min_length: 8, min_numeric: 0, min_alpha: 0, min_punctuation: 0, exclude: "" }
			opts = default_options.merge options
			field_name = opts[:password_field].to_s.humanize
			field_value = record[opts[:password_field]]
			record.errors[:base] << I18n.t("toaster.error.min_length", field: field_name, min: opts[:min_length]) if field_value.length < opts[:min_length]
			record.errors[:base] << I18n.t("toaster.error.min_numeric", field: field_name, min: opts[:min_numeric]) if field_value.count("0-9") < opts[:min_numeric]
			record.errors[:base] << I18n.t("toaster.error.min_alpha", field: field_name, min: opts[:min_alpha]) if field_value.count("A-Za-z") < opts[:min_alpha]
			record.errors[:base] << I18n.t("toaster.error.min_punctuation", field: field_name, min: opts[:min_punctuation]) if field_value.count("^A-Za-z0-9 ") < opts[:min_punctuation]
			record.errors[:base] << I18n.t("toaster.error.invalid_characters", field: field_name, characters: opts[:exclude].chars.join(" ")) if field_value.count(opts[:exclude]) > 0
		end
	end
end

class ActiveRecord::Base
	include Toaster
end