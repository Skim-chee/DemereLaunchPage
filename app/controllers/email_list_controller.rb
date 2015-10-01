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

	def custom_mail_btn
		Email.all.each do |e|
			e.send_custom_mail
		end
		 render :nothing => true
	end
end
