class ApplicationController < ActionController::Base
  protect_from_forgery
  
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :notice => exception.message
  end

  check_authorization

  after_filter :flash_to_headers

  private

  def flash_to_headers
    if request.xhr?
      [:info, :success, :warning, :error].each do |type|
        response.headers["X-message-#{type}"] = flash[type] if flash[type]
      end
      flash.discard
    end
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  helper_method :current_user
end
