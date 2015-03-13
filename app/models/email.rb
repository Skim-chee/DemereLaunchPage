class Email < ActiveRecord::Base

	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

	validates :email, 
	presence: true,
	uniqueness: { case_sensitive: false }, 
	format: {with: VALID_EMAIL_REGEX}

	def send_confirmation
		self.update_column(:email_confirm_token, SecureRandom.urlsafe_base64)
		ConfMailer.send_confirmation_mail(self).deliver
	end
end
