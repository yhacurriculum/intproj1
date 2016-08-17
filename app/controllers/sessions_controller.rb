class SessionsController < ApplicationController
  
  def create
  	user = User.from_omniauth(request.env["omniauth.auth"])
    session[:user_id] = user.id

    
    
    if (current_user)
      if ((current_user.name).to_s).length > 20
        redirect_to edit_user_path(current_user)
      else
         redirect_to root_path
      end
    end

    
  end
  
  def destroy
  	session[:user_id] = nil
    redirect_to root_path
  end
  
  
 
end
