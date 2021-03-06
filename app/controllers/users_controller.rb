class UsersController < ApplicationController
    
    before_filter :confirm_logged_in, :only => [:show, :edit, :update, :destroy]
    

    before_action :correct_user,   only: [:edit, :update, :destroy]
    before_action :set_user, only: [:show, :edit, :update, :destroy]

    
    def index
        
        @users = User.page(params[:page]).per(6)
        if params[:search]
            @users = @users.search(params[:search]).order("created_at DESC")
        else
            @users = @users.all.order('created_at DESC')
        end
        
    end
    
    def show
    end
    
    def edit
    end
    
    def update
       respond_to do |format|
         if @user.update(user_params)
           format.html { redirect_to @user, notice: 'User was successfully updated.' }
           format.json { render :show, status: :ok, location: @user }
         else
           format.html { render :edit }
           format.json { render json: @user.errors, status: :unprocessable_entity }
         end
        end
    end
    
    def destroy
       @user.destroy
       respond_to do |format|
         format.html { redirect_to signout_path, notice: 'User was successfully destroyed.' }
         format.json { head :no_content }
       end
    end
    
    private
       # Use callbacks to share common setup or constraints between actions.
       def set_user
         @user = User.find(params[:id])
       end
    
       # Never trust parameters from the scary internet, only allow the white list through.
       def user_params
         params.require(:user).permit(:name, :bio, :dob, :phone, :state, :city, :zip, :admin, :image_url, :ban)
       end
        
end
