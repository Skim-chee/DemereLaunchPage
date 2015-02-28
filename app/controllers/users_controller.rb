class UsersController < ApplicationController
	def new
		@user = User.new
	end

	def create
		@user = User.new(user_params)
		if @user.save
			@email.send_confirmation
			flash[:info] = "Please check your email to activate your account."
			redirect_to root_url, notice: "Making your account!"
		else
			render 'new'
		end
	end

	def account_confirmation	
		@user = User.find_by_email_confirm_token(params[:token])
		if(@user)
			@user.update_column(:activated, true)
			@user.update_column(:activation_digest, nil)
			redirect_to root_url, :notice => "Account confirmed"
			flash[:info] = "Account confirmed."
		else
			redirect_to root_url, :notice => "Account could not be confirmed"
		end
	end

	private

	def user_params
		params.require(:email).permit(:email)
	end
end
