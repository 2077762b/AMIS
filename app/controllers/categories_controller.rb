class CategoriesController < ApplicationController

  # Get all posts in the current category ordered by decreasing number of bids
  def show
    @category = Category.find(params[:id])
    @subs = Subcategory.where(category: @category)
    @posts = Post.where(subcategory: @subs).order("views DESC")
  end

end
