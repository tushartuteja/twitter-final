class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  #protect_from_forgery with: :exception
  # helper_method :current_user, :user_signed_in?

  # def user_signed_in?
  #   !session[:user_id].nil?
  # end


  # def current_user
  #   if user_signed_in?
  #     User.find(session[:user_id])
  #   end
  # end


  # def authenticate_user
  #   unless user_signed_in?
  #     return redirect_to '/signin'
  #   end
  # end
end
