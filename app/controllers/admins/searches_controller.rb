class Admins::SearchesController < ApplicationController
    def search
      @electronics_or_user = params[:option]
      if @electronics_or_user == '1'
        @electronics = Electronics.search(params[:search], @electronics_or_user)
      else
        @users = User.search(params[:search], @electronics_or_user)
      end
      render action: :search
    end
  end