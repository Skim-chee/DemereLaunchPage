class DelayedMailer < ActionMailer::Base
	include Resque::Mailer
	default from: "demere@demere.co"
	layout 'delayed_mailer'

	def delayed_mailer(email)
		@email = email
		mail(to: @email.email, subject: 'Demere follow-up') 
	end
end
