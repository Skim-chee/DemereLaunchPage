class EmailListController < ApplicationController
	before_filter :authenticate

	def authenticate
		authenticate_or_request_with_http_basic('Administration') do |username, password|
			username == 'demere' && password == 'david'
		end
	end

	def email_list
		@email_list = Email.all
	end
end
