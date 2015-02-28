class User < ActiveRecord::Base

	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

	validates :email, 
	presence: true,
	length: {maximum: 255},
	uniqueness: { case_sensitive: false },
	format: {with: VALID_EMAIL_REGEX}

	# Will all be input at the initial sign up page
	validates :age,
	presence: true,
	length: {maximum: 3}
	validates :city,
	presence: true,
	length: {maximum: 255}
	# Will be presented in a dropdown menu
	validates :state,
	presence: true
	# Will be presented as Male/Female buttons
	validates :gender,
	presence: true


	has_secure_password
end
