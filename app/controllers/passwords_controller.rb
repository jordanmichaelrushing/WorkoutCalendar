class PasswordsController < ApplicationController

  def index
    if session[:verified] == true
      redirect_to today_workouts_path
    else
      render 'index', layout: false
    end
  end

  def verify
    if params[:password] == ENV['PASSWORDPROTECTED']
      session[:verified] = true
      redirect_to today_workouts
    else
      render :file => "#{Rails.root}/public/404.html",  :status => 404, layout: false
    end
  end
end