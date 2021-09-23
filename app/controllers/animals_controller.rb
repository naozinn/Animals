class AnimalsController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:edit, :update, :destroy]

  def show
    @animal = Animal.find(params[:id])
    @user = @animal.user
    @animal_new = Animal.new
    @animal_comment = AnimalComment.new
  end

  def edit
    @animal = Animal.find(params[:id])
    flash[:notice2] = "You have updated animal successfully."
    if @animal.user == current_user
      render "edit"
    else
      redirect_to animals_path
    end
  end

  def update
    @animal = Animal.find(params[:id])
    if@animal.update(animal_params)
    redirect_to animal_path
    else
    render :edit
    end
  end

  def create
    @animal = Animal.new(animal_params)
    @animal.user_id = current_user.id
    if @animal.save
      flash[:notice] = "You have created animal successfully."
      redirect_to animal_path(@animal)
    else
      @Animals = Animal.all
      @user = current_user
      render :index
    end
  end

  def index
    @animals = Animal.all
    @animal = Animal.new
    @user = current_user
  end

  def destroy
    @animal = Animal.find(params[:id])
    @animal.destroy
    if @animal.user == current_user
      redirect_to animals_path
    else
    end
  end

  private

  def animal_params
    params.require(:animal).permit(:title, :body, :animal_image)
  end

  def ensure_correct_user
    @animal = Animal.find(params[:id])
    unless @animal.user == current_user
      redirect_to animals_path
    end
  end
end
