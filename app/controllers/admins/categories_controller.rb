class Admins::CategoriesController < ApplicationController
    before_action :authenticate_admin!
    def create
      @category_new = Category.new(category_params)
      if @category_new.save
        redirect_to request.referer
      else
        @categories = Category.all
        render action: :index
      end
    end
  
    def index
      @category_new = Category.new
      @categories = Category.all
    end
  
    def edit
      @category = Category.find(params[:id])
    end
  
    def update
      @category = Category.find(params[:id])
      if @category.update(category_params)
        redirect_to admins_categories_path
      else
        render action: :edit
      end
    end
  
    def destroy
      @category = Category.find(params[:id])
      @category.destroy
      redirect_to request.referer
    end
  
    private
  
    def category_params
      params.require(:category).permit(:category_name, :effective_life)
    end
  end