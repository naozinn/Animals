class SearchesController < ApplicationController
  before_action :authenticate_user!

  def search
    @model = params[:model]
    @value = params[:value]
    @how = params[:how]
    if @model == 'user'
        @records = User.search_for(@value,@how)
    else
        @records = Animal.search_for(@value,@how)
    end
  end

end
