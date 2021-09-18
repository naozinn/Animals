class AnimalCommentsController < ApplicationController
  before_action :authenticate_user!

	def create
		@animal = Animal.find(params[:animal_id])
		@animal_comment = AnimalComment.new(animal_comment_params)
		@animal_comment.animal_id = @animal.id
		@animal_comment.user_id = current_user.id
		if @animal_comment.save
  		redirect_to animal_path(@animal.id)
		else
		  render 'animals/show'
		end
	end

	def destroy
		@animal = Animal.find(params[:animal_id])
  		animal_comment = @animal.animal_comments.find(params[:id])
		animal_comment.destroy
		redirect_to request.referer
	end

	private
	def animal_comment_params
		params.require(:animal_comment).permit(:comment)
	end
end
