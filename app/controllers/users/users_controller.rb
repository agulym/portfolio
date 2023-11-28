class Users::UsersController < ApplicationController
    before_action :authenticate_user!
    before_action :correct_user, only: %i[edit update]
    def index
      @categories = Category.all
      @users = User.all
      @notices = Notice.all
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
        redirect_to user_path(@user.id)
      else
        render 'edit'
      end
    end
  
    private
  
    def correct_user
      @user = User.find(params[:id])
      redirect_to user_path(current_user.id) if @user != current_user
    end
  
    def user_params
      params.require(:user).permit(:user_name, :introduction, :profile_image, :gender)
    end
  end