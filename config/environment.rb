# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
Rails.application.initialize!

ActionMailer::Base.smtp_settings = {
  :user_name => ENV["MAILER_USERNAME"],
  :password => ENV["MAILER_PASSWORD"],
  :domain => 'closetinmypocket.com',
  :address => 'smtp.mandrillapp.com',
  :port => 587,
  :authentication => :plain,
  :enable_starttls_auto => true
}