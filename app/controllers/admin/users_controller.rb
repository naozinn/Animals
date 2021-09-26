class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!

  def index
    @users = User.page(params[:page]).per(10)
  end

  def show
    @user = User.find(params[:id])

  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
       flash[:notice] = "会員情報の更新が完了しました"
       redirect_to admin_users_path
    else
      render :edit
    end

  end

  private
  def user_params
    params.require(:user).permit(:email,:name,)
  end

end
