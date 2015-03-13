class EmailsController < ApplicationController
	def new
		@email = Email.new
	end

	def create
		@email = Email.new(email_params)
		# If new email is input and saved, send confirmation email, 
		# flash success message, and redirect to home page
		if @email.save
			@email.send_confirmation
			flash[:success] = "Please check your email to activate your account."
			redirect_to root_url
		else
			flash[:success] = "You logged in!"
			render 'new'
		end
	end

	def account_confirmation	
		# Finds an email by its email_confirm_token 
		@email = Email.find_by_email_confirm_token(params[:token])
		# If the appropriate email is found, activate it and set it's token to nil, then redirect back to home page
		if(@email)
			@email.update_column(:activated, true)
			@email.update_column(:email_confirm_token, nil)
			redirect_to root_url, :notice => "Account confirmed"
			flash[:success] = "Account confirmed."
		else
			redirect_to root_url, :notice => "Account could not be confirmed"
		end
	end

	private

	def email_params
		params.require(:email).permit(:email)
	end
end
