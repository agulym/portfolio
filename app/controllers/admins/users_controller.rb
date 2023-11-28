class Admins::UsersController < ApplicationController
    before_action :authenticate_admin!
    def index
      @users = User.all
    end
  
    def show
      @user = User.find(params[:id])
      @electronics = @user.electronics
    end
  
    def edit
      @user = User.find(params[:id])
    end
  
    def update
      @user = User.find(params[:id])
      if @user.update(user_params)
        redirect_to admins_user_path(@user.id)
      else
        render action: :edit
      end
    end
  
    def destroy
      @user = User.find(params[:id])
      @user.destroy
      redirect_to admins_users_path
    end
  
    private
  
    def user_params
      params.require(:user).permit(:user_name, :introduction, :profile_image, :gender)
    end
  end