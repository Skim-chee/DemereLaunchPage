class EmailStepsController < ApplicationController
  include Wicked::Wizard
  steps :info

  def show
    @email = Email.new
    render_wizard
  end

  def update
    @email = Email.find(session[:id])
    puts session[:id]
    puts @email
    puts @email.email
    puts "TESTSTSINTSDEBUG"
    @email.update_attributes(info_params)
    if @email.valid?(:second)
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
