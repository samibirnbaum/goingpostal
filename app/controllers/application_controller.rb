class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper #this module, which will now be inherited via apllication controller to all controllers in the app

  private
    def require_sign_in
      unless current_user #only do this if there is no user id in the session object
        flash[:alert] = "sorry you need to be logged in to do that" #show up on next rendered page
        redirect_to(new_session_path)
      end
    end
end
