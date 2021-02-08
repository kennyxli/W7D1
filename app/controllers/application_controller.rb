class ApplicationController < ActionController::Base
    def login!(user)
        session[:session_token] = user.reset_session_token!
        #clarify why we're updating the session hash
    end
end
