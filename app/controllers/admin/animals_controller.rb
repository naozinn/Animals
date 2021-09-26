class Admin::AnimalsController < ApplicationController
  before_action :authenticate_admin!

  def destroy
    @animal = Animal.find(params[:id])
    @animal.destroy
    redirect_to admin_root_path
  end

end
