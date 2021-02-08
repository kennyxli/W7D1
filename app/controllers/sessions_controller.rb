class SessionsController < ApplicationController
    before_action :require_logged_out, only: [:new, :create]
    before_action :require_logged_in, only: [:destroy]
    
    def new
        @user = User.new
        render :new
    end
    def create
        @user = User.find_by_credentials(params[:user][:user_name], params[:user][:password])
        #the value of the :user key has to match name from new form
        if @user
            login_user!(@user)
            redirect_to cats_url
        else
            @user = User.new
            render :new
        end
    end
    def destroy
        logout!
        redirect_to new_session_url #how does the new_session_url get generated?
    end
end
