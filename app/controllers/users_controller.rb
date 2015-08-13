class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :destroy, :update]
  skip_before_filter :require_login, only: [:new, :create]

  def new
    @user = User.new
  end

  def create
    @user = User.create(user_params)
    if @user.errors.empty?
      @user = login(params[:user][:email], params[:user][:password])
      redirect_to @user
    else
      render "new"
    end
  end

  def show
  end

  def edit
  end

  def update
    @user.update_attributes(user_params)
    if @user.errors.empty?
      redirect_to @user
    else
      render "edit"
    end
  end

  def destroy
    @user.destroy
    redirect_to root_path
  end

  private

  def set_user
    @user = current_user
  end

  def user_params
    params.require(:user).permit(:email, :password, :authentications_attributes)
  end
end
