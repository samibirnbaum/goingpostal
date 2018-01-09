module SessionsHelper
    def create_session(user)
        session[:user_id] = user.id #set the session object to have a user id
    end

    def destroy_session(user)
        session[:user_id] = nil #set the session object to not have a user 
    end

    def current_user
        User.find_by(id: session[:user_id])
    end
end
