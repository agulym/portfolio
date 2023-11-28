class Admins::ElectronicsController < ApplicationController
    before_action :authenticate_admin!
    def index
      @categories = Category.all
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
      @electronics.useful_life = @electronics.after_month
      if @electronics.update(electronics_params)
        redirect_to admins_electronics_path(@electronics.id)
      else
        render action: :edit
      end
    end
  
    def destroy
      @electronics = Electronics.find(params[:id])
      @electronics.destroy
      redirect_to admins_electronics_path
    end
  
    private
  
    def electronics_params
      params.require(:electronics).permit(:user_id, :category_id, :maker, :image, :product, :model, :purchase_amount, :purchase_day, :warranty_period, :start_operation, :useful_life, :place, :frequency, :detail)
    end
  
    def electronics_after_month
      electronics_params.merge(@electronics_new.after_month)
    end
  end