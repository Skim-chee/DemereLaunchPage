class Email < ActiveRecord::Base

	belongs_to :referrer, :class_name => "Email", :foreign_key => "referrer_id"
	has_many :referrals, :class_name => "Email", :foreign_key => "referrer_Id"

	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

	validates :email,
    presence: {message: "is missing"},
			format: {with: VALID_EMAIL_REGEX, message: "is not valid"},
			on: :first

	validates :name,
		presence: {message: "is missing"},
		format: {with: /\A([a-zA-Z]|\s|\-|\.)+\z/, message: "is not valid"},
		on: :second

	validates :zipcode,
		presence: {message: "is missing"},
		format: {with: /\d+/, message: "is not valid"},
		on: :second

	validates :referral_code,
	uniqueness: true

	
	# Array of hashes describing the reward levels for referring friends
	REFERRAL_STEPS = [
        {
            'count' => 5,
            "html" => "Five<br>Dollers",
            "class" => "two",
            # "image" =>  ActionController::Base.helpers.asset_path("refer/cream-tooltip@2x.png")
        },
        {
            'count' => 10,
            "html" => "Fifteen<br>Dollars",
            "class" => "three",
            # "image" => ActionController::Base.helpers.asset_path("refer/truman@2x.png")
        },
        {
            'count' => 25,
            "html" => "Fourty<br>Dollars",
            "class" => "four",
            # "image" => ActionController::Base.helpers.asset_path("refer/winston@2x.png")
        },
        {
            'count' => 50000,
            "html" => "Become CEO<br>of our Company",
            "class" => "five",
            # "image" => ActionController::Base.helpers.asset_path("refer/blade-explain@2x.png")
        }
    ]


	# Sets Email's email_confirmation_token to a random token for use in activating ones email
	def send_confirmation
		WelcomeMailer.welcome_email(self).deliver
	end

    def send_custom_mail
        CustomMailer.custom_email(self).deliver
    end


	   # Generates unique referall code for Email
    def create_referral_code
        referral_code = SecureRandom.hex(5)
        @collision = Email.find_by_referral_code(referral_code)

        while !@collision.nil?
            referral_code = SecureRandom.hex(5)
            @collision = Email.find_by_referral_code(referral_code)
        end

        self.referral_code = referral_code
    end

end
