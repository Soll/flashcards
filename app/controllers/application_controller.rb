class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :require_login, except: [:not_authenticated]
  before_filter :set_locale

  def set_locale
    locale = if current_user
        locale = current_user.locale
      elsif params[:locale]
        session[:locale] = params[:locale]
      elsif session[:locale]
        session[:locale]
      else
        http_accept_language.compatible_language_from(I18n.available_locales)
      end

    if locale && I18n.available_locales.include?(locale.to_sym)
      session[:locale] = I18n.locale = locale.to_sym
    end
  end

  def default_url_options(options={})
   {:locale => I18n.locale}
 end

  protected

  def not_authenticated
    redirect_to login_path, notice: "Login required!"
  end
end
