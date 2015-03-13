class ConfMailer < ApplicationMailer
	default from: "noreply@closetinmypocket.com"

	def send_confirmation_mail(email)
		@email = email
		mail(to: @email.email, subject: 'Newsletter Registration confirmation')
	end
end
