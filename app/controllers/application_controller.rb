class ApplicationController < ActionController::Base
    helper_method :current_user, :logged_in?

    def login!(user)
        session[:session_token] = user.reset_session_token!
        #clarify why we're updating the session hash
    end

    def current_user
       @current_user ||= User.find_by(session_token: session[:session_token])
    end

    def logout!
        current_user.reset_session_token! if logged_in? #why can't we just set the session token to nil--
        #why do we need to reset it first
        session[:session_token] = nil
        @current_user = nil
    end

    def logged_in?
        !!current_user 
        #why not "current_user?"
    end
end
