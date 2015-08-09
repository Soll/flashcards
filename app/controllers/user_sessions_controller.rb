class UserSessionsController < ApplicationController
  skip_before_filter :require_login, :only => [:new, :create]

  def new
  	@user = User.new
  end

  def create
  	if @user = login(params[:user][:email], params[:user][:password], false)
  		redirect_back_or_to current_user, notice: "Login successful"
  	else
      flash.now.alert = "Login failed"
      redirect_to login_path
    end
  end

  def destroy
  	logout
    redirect_to root_path, notice: "Logged out!"
  end

  private
  def user_params
    params.require(:user).permit(:email, :password)
  end
end
