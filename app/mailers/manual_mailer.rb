class ManualMailer < ApplicationMailer
	default from: "demere@demere.co"

	def manual_email(email)
		@email = email
		mail(to: @email.email, subject: 'Thank you for signing up!')
	end
end
