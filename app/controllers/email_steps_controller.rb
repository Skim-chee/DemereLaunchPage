class EmailStepsController < ApplicationController
  include Wicked::Wizard
  steps :info

  def show
    @email = Email.new
    render_wizard
  end

  def update
    @email = Email.new(info_params)
    @email.email = session[:email]
    if @email.valid?(:second)
      current_ip = IpAddress.find_by_address(request.remote_ip)

			if !current_ip
				current_ip = IpAddress.create(
					:address => request.remote_ip,
					:count => 0
				)
			end

			if current_ip.count > 9
				flash[:danger] = "Too many accounts are already linked to this ip address"
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
				@email.referrer = @referred_by
			end
      @email.save
      render 'emails/refer'
      puts "GOOD TO GO"
    else
      if @email.errors.any?
				flash[:danger] = @email.errors.full_messages.first
			end
      redirect_to email_steps_path
    end
  end


  private
  def info_params
    params.require(:email).permit(:name, :zipcode)
  end
end
