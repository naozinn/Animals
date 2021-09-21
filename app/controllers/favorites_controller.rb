class FavoritesController < ApplicationController
  before_action :authenticate_user!

  def create
    @animal = Animal.find(params[:animal_id])
    favorite = @animal.favorites.new(user_id: current_user.id)
    favorite.save
  end

  def destroy
    @animal = Animal.find(params[:animal_id])
    favorite = @animal.favorites.find_by(user_id: current_user.id)
    favorite.destroy
  end

end


