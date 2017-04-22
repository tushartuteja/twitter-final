class AdminController < ApplicationController
  before_action :authenticate_user!
  before_action :check_admin_or_moderator!
  before_action :check_admin! only: [:revoke_admin, :grant_admin]

  def users
  end

  def revoke_admin
  end

  def grant_admin
  end

  private
  def check_admin!
  	unless current_user.admin? 
  		return redirect_to '/'
  	end
  end

  def check_admin_or_moderator!
  end






end
