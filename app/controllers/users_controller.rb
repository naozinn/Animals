class UsersController < ApplicationController
  before_action :correct_user, only: [:edit, :update]

  def show
    @user = User.find(params[:id])
    @animals = @user.animals
    @animal = Animal.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
    redirect_to user_path(@user.id)
    flash[:notice] = "You have updated user successfully."
    else
      render :edit
    end
  end

  def create
    @user = User.new
    redirect_to books_path
  end

  def index
    @Animals = Animal.all
    @animal = Animal.new
    @user = current_user
    @users = User.all
  end

  private

  def user_params
    params.require(:user).permit(:name, :image,:introduction,:title)
  end

  def correct_user
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to user_path(current_user.id)
    end
  end

end
