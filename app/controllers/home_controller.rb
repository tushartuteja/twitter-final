class HomeController < ApplicationController
  def index
  	if user_signed_in?
  		@user = current_user
  	else
  		return redirect_to '/signin'
  	end
  end
end
