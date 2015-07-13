class WelcomeMailer < ApplicationMailer
	default from: "team@demere.co"

	def welcome_email(email)
		@email = email
		mail(to: @email.email, subject: 'Thank you for signing up!')
	end
end
