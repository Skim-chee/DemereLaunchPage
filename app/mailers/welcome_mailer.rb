class WelcomeMailer < ActionMailer::Base
	default from: "demere@demere.co"
	layout 'welcome_mailer'

	def welcome_email(email)
		@email = email
		mail(to: @email.email, subject: 'Thank you for signing up!')
	end
end
