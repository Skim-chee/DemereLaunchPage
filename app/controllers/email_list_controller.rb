class EmailListController < ApplicationController
	def email_list
		@email_list = Email.all
	end
end
