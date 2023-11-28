class Users::ElectronicsController < ApplicationController
    before_action :authenticate_user!
    before_action :correct_user, only: %i[edit update]
    def top
      @categories = Category.all
      @notices = Notice.all
      @electronics = Electronics.all.order(created_at: :desc)
    end
  
    def new
      @categories = Category.all
      @electronics_new = Electronics.new
    end
  
    def create
      @electronics_new = Electronics.new(electronics_params)
      @electronics_new.user = current_user
      @electronics_new.useful_life = @electronics_new.after_month
      if @electronics_new.save
        redirect_to electronics_path(@electronics_new.id)
      else
        render action: :new
      end
    end
  
    def index
      @categories = Category.all
      @notices = Notice.all
      @users = User.all
      if params[:id]
        @category = Category.find(params[:id])
        @electronics = @category.electronics.all
      else
        @electronics = Electronics.all
      end
    end
  
    def show
      @electronics = Electronics.find(params[:id])
    end
  
    def edit
      @electronics = Electronics.find(params[:id])
    end
  
    def update
      @electronics = Electronics.find(params[:id])
      @electronics.user = current_user
      @electronics.useful_life = @electronics.after_month
      if @electronics.update(electronics_params)
        redirect_to electronics_path(@electronics.id)
      else
        render action: :edit
      end
    end
  
    def destroy
      @electronics = Electronics.find(params[:id])
      @electronics.destroy
      redirect_to electronics_path
    end
  
    private
  
    def correct_user
      @electronics = Electronics.find(params[:id])
      @user = @electronics.user
      redirect_to appliances_path if @user != current_user
    end
  
    def electronics_params
      params.require(:electronics).permit(:user_id, :category_id, :maker, :image, :product, :model, :purchase_amount, :purchase_day, :warranty_period, :start_operation, :useful_life, :place, :frequency, :detail)
    end
  
    def electronics_after_month
      electronics_params.merge(@electronics_new.after_month)
    end
  end