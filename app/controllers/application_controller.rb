class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :ref_to_cookie

  protected

  def ref_to_cookie
    # If referral code found in url, turn it into a cookie h_ref for use in emails_controller
    if params[:ref]
      if Email.find_by_referral_code(params[:ref])
        # Sets the h_ref cookie based on the presence of :ref with an expiration date of 1 week
        cookies[:h_ref] = { :value => params[:ref], :expires => 1.week.from_now }
      end
      # What is this I don't know 
      if request.env["HTTP_USER_AGENT"] and !request.env["HTTP_USER_AGENT"].include?("facebookexternalhit/1.1")
        redirect_to proc { url_for(params.except(:ref)) }  
      end
    end
  end
end
