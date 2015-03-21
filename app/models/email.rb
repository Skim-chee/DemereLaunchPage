class Email < ActiveRecord::Base

	belongs_to :referrer, :class_name => "Email", :foreign_key => "referrer_id"
	has_many :referrals, :class_name => "Email", :foreign_key => "referrer_Id"

	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

	validates :email, 
    uniqueness: { case_sensitive: false }, 
	format: {with: VALID_EMAIL_REGEX}

	validates :referral_code,
	uniqueness: true

	before_create :create_referral_code
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
		self.update_column(:email_confirm_token, SecureRandom.urlsafe_base64)
		ConfMailer.send_confirmation_mail(self).deliver
	end

	private
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
