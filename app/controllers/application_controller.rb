class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper #this module, which will now be inherited via apllication controller to all controllers in the app
end
