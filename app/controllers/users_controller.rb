class UsersController < ApplicationController
    before_action :require_logged_out, only: [:new, :create]

    def new
        @user = User.new
        render :new
    end

    def create
        user = User.new(user_params) #why do we use "user" and not "@user" here?
        #because we don't need to call the instance of @user in a view, we are just rendering json here 
        if user.save
            login_user!(user)
            redirect_to user_url(user)
        else
            render json: user.errors.full_messages, status: 422
        end
    end

    private
    def user_params
        params.require(:user).permit(:user_name, :password)
    end
    





    
end
