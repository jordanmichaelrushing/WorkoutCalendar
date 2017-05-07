class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :check_alpha

  def check_alpha
    unless params[:legalize_it] || session[:legalize_it] || Rails.env.development?
      render(file: File.join(Rails.root, 'public/404.html'), status: 404, layout: false)
    else
      session[:legalize_it] = true
    end
  end
end
