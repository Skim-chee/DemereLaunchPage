class EmailsController < ApplicationController

	def new
		@email = Email.new
	end

	def create
		@em = Email.new(email_params)
		if @em.valid?(:first)
			@email = Email.find_by(email_params)
		else
			puts "TESTING ERRORR"
			if @em.errors.any?
				flash[:danger] = @em.errors.full_messages.first
			end
			return redirect_to root_url
		end
		# @email = Email.new(email_params)
		# If new email is input and saved, send confirmation email,
		# flash success message, and redirect to home page
		if !@email
			# @email.send_confirmation
				session[:email] = @em.email
				session[:id] = @em.id
				puts "THIS MAH SESSION ID"
				puts session[:id]
				return redirect_to email_steps_path
		end

		if @email
			cookies[:h_email] = { :value => @email.email}
			puts "SUCCESSSSSS"
			render 'emails/refer'
		else
			flash[:alert] = "Something went wrong!"
			puts "FAILUREEEEEE"
			redirect_to root_url
		end

	end

	def current_email
		@email
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

	def info_params
		params.require(:name).permit(:name, :zipcode)
	end

	def skip_first_page
		email = cookies[:h_email]
		if email and Email.find_by_email(email)
			redirect_to '/refer'
		else
			cookies.delete :h_email
		end
	end
end
