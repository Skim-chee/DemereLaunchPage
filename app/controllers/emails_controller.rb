class EmailsController < ApplicationController
	before_action :skip_first_page, only: :new

	def new
		@email = Email.new
	end

	def create
		@email = Email.find_by(email_params)
		@em = Email.new(email_params)

		if !@email and @em.valid?(:first)
			current_ip = IpAddress.find_by_address(request.remote_ip)

			if !current_ip
				current_ip = IpAddress.create(
				:address => request.remote_ip,
				:count => 0
				)
			end

			if current_ip.count > 9
				flash[:alert] = "Too many accounts are already linked to this ip address"
				return redirect_to root_url
			else
				current_ip.count = current_ip.count + 1
				current_ip.save
			end

			if current_ip.count < 10
				@referred_by = Email.find_by_referral_code(cookies[:h_ref])
			end

			puts '----TESTING----'
			puts @referred_by.email if @referred_by
			puts request.remote_ip.inspect
			puts current_ip.count
			puts '----END TESTING----'

			if !@referred_by.nil?
				@em.referrer = @referred_by
			end

			# If new email is input and saved, send confirmation email,
			# flash success message, and redirect to home page
			#
			# @em.send_confirmation
			cookies[:h_email] = {:value => @em.email}
			puts cookies[:h_email]
			puts "COOKIE"
			@em.save
			session[:id] = @em.id
			puts "THIS MAH SESSION ID"
			puts session[:id]
			return redirect_to email_steps_path
		end

		if @email
			cookies[:h_email] = { :value => @email.email}
			puts "SUCCESSSSSS"
			@email.update(visited: true)
			render 'emails/refer'
		else
			flash[:alert] = "Please enter a valid email address"
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
		if !Rails.application.config.ended
            @email = Email.find_by_email(cookies[:h_email])
						puts @email
						puts "POOP"
            if @email and !Email.find_by_email(@email).nil?
                return render 'emails/refer'
            else
                cookies.delete :h_email
            end
        end
	end
end
