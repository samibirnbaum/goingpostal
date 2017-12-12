class WelcomeController < ApplicationController #ApplicationController inherits from ActionController::Base, which defines a number of helpful methods.
  def index   #automatically renders this view (default rendering) when user navigates to welcome/index
  end

  def about   #automatically renders this view (default rendering)
  end
end


#ApplicationController/ActionController handles a lot of routing in the background