class SessionsController < ApplicationController
    def new
        
    end

    def create
        #based off log in form, find user by email
        user = User.find_by(email: params[:session][:email].downcase) #on sign up email downcased before_save

        if user && user.authenticate(params[:session][:password])
            create_session(user) #wishful coding
            flash[:notice] = "Welcome #{user.name}!"
            redirect_to(root_path)
        else
            flash.now[:alert] = "Invalid email or password"
            render :new
        end
    end

    def destroy
        destroy_session(current_user) #wishful coding
        flash[:notice] = "You have been successfully signed out"
        redirect_to(root_path)
    end
end
