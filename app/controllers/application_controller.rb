class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
 
  protect_from_forgery

  protected

  def current_user
     @current_user ||= User.find_by(id: session[:user_id])
  end
  

  def signed_in?
    !!current_user
  end
  helper_method :current_user, :signed_in?

  def current_user=(user)
    @current_user = user
    session[:user_id] = user.nil? ? nil : user.id
  end
  
  def confirm_logged_in
    unless session[:user_id]
        flash[:notice] = "Please log in"
        redirect_to :root
        return false
    else
        return true
    end
  end 
  
  # Confirms the correct user.
  def correct_user
    if !(current_user.try(:admin?))
        @user = User.find(params[:id])
        redirect_to(root_url) unless @user == current_user
    end
  end
  
end

