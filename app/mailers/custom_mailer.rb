class CustomMailer < ActionMailer::Base
	default from: "demere@demere.co"
	layout 'custom_mailer'

	def custom_email(email)
		@email = email
		mail(to: @email.email, subject: 'Sorry about that!')
	end
end
