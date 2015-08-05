class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_filter :require_login, :except => [:not_authenticated]

  protected

  def not_authenticated
    redirect_to login_path, notice: "Login required!" 
  end
end
