class Users::NoticesController < ApplicationController
    before_action :authenticate_user!
    def show
      @notices = Notice.find(params[:id])
    end
  end