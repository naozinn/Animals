class Admin::HomesController < ApplicationController

  def top
    @animals = Animal.all.page(params[:page]).per(10)
  end

  def destroy
    @animal = Animal.find(params[:id])
    @animal.destroy
    redirect_to admin_root_path
  end

end
