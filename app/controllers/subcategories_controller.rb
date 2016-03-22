class SubcategoriesController < ApplicationController

  # Get all posts in the current subcategory ordered by decreasing number of bids
def show
    @subcategory = Subcategory.find(params[:id])
    @posts = Post.where(subcategory: @subcategory).order("views DESC")
  end

end
