class PostsController < ApplicationController

  # A trader should be logged in for all actions except show and index
  before_action :authenticate_trader!, except: [:show, :index]

  # Get the current post for all except the following actions
  before_action :set_post, except: [:new, :create, :request_delivered, :request_sample, :index, :report]

  # Get post for request sample structure
  before_action :before_request, only: [:request_sample, :report]

  # For any methods that involve changing a post it is checked that the current logged in trader
  # is the owner of the posts
  before_action :check_user, only: [:edit, :update, :destroy]

  # These actions can only be carried out if the post is still active
  before_action :check_active, only: [:show, :edit, :update, :request_sample, :report, :destroy]

  # Checks for a unique session id, in order to have a view counter on posts
  impressionist actions: [:show], unique: [:session_hash]

  # Shows an active post
  def show
    # Update the view counter if the viewer has a unique session hash
    impressionist(@post, nil, { unique: [:session_hash] })

    # Checks if the current trader is allowed to buy the item in this post
    if current_trader
      @in_buy_cat = ApprovedBuyCat.where(trader_id: current_trader.id).where(status: "1").exists?(:buy_cat_id => @post.subcategory_id)
    end
    @bid = Bid.new(post_id: @post.id)

    # Get the rating for the post
    ratings = Trade.includes(:post).where(posts: { trader_id: @post.trader_id } ).collect{|m| m.rating.to_i}.compact
    length = ratings.collect{|m| if m != 0
                                   m
                                 end}.compact.length

    @rating = ratings.sum.to_f / (length == 0? 1 : length)
    if @rating == nil
      @rating = 0
    end

  end

  # This page shows the results of a search
  def index
    if params[:search]
      @posts= Post.search(params[:search])
    else
      @posts= Post.order("created_at DESC")
    end
  end

  # Allows a trader to make a new post
  def new
    @post = Post.new
    @approved = ApprovedSellCat.where(trader_id: current_trader.id, status: 1)
    # If not approved in any seller category then the trader cannot create a post
    if (@approved.length == 0)
      render :unapproved
    else
      # Get approved categories
      @approved_cat = approved_sell_categories
    end
  end

  # Allows a trader to edit a post
  def edit
    @approved = ApprovedSellCat.where(trader_id: current_trader.id, status: 1)
    # Get approved categories
    @approved_cat = approved_sell_categories
  end

  # Create a new post
  def create
    @post = Post.new(post_params)
    @post.trader_id = current_trader.id

    respond_to do |format|
      # Try to save post. If it fails reload new post page.
      if @post.save
        format.html { redirect_to profiles_path(current_trader.id), notice: 'Post was successfully created.' }
      else
        # Get approved categories and render the new post page again
        @approved_cat = approved_sell_categories
        format.html { render :new }
      end
    end
  end

  # Update a post
  def update
    respond_to do |format|
      # Try to save post. If it fails reload new post page.
      if @post.update(post_params)
        format.html { redirect_to profiles_path(current_trader.id), notice: 'Post was successfully updated.' }
      else
        # Get approved categories and render the edit post page again
        @approved_cat = approved_sell_categories
        format.html { render :edit }
      end
    end
  end

  # Allows a trader to request a sample of a post product
  def request_sample

    respond_to do |format|

      # Checks that the form has been filled out correctly
      if params[:line1].blank? or params[:city].blank? or params[:county].blank? or params[:postcode].blank?
        format.html { redirect_to @post, notice: 'To request a sample you must provide your full address.' }
      else
        # Creates a new sample and redirect to the profile page
        @request = Request_Sample.new
        @request.post_id = @post.id
        @request.seller_id = @post.trader_id
        @request.requestee_id = current_trader.id
        @request.line1 = params[:line1]
        @request.city = params[:city]
        @request.county = params[:county]
        @request.postcode = params[:postcode]
        @request.save
        format.html { redirect_to profiles_path(current_trader.id), notice: 'Request made.' }
      end
    end
  end

  # Allows a seller to dismiss the sample request once they have sent it
  def request_delivered
    @request = Request_Sample.find(params[:request])
    @request.destroy
    respond_to do |format|
      format.html { redirect_to profiles_path(current_trader.id)}
      format.json { head :no_content }
    end
  end

  # Allows a trader to report a post they think is suspicious
  def report
    @post = Post.find(params[:post])
    @post.report = true
    @post.save
    redirect_to home_path, notice: 'Post successfully reported.'
  end

  # Allows a trader to destroy one of their posts
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to profiles_path(current_trader.id), notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Get the current post
    def set_post
      @post = Post.find(params[:id])
    end

    # Set allowed parameters
    def post_params
      params.require(:post).permit(:subcategory_id, :name, :description, :quantity, :price, :provide_samples,
                                   :trader_id, :private, :delivery, :active, :image, :line1, :city,
                                   :county, :postcode, :delivery_days, :auction)
    end

    # Check that the current trader is the owner of the post
    def check_user
      if (@post.trader.id != current_trader.id)
        # Otherwise redirect to the show page
        redirect_to action: "show", id:params[:id]
      end
    end

    # Get the post for the request sample structure
    def before_request
      @post = Post.find(params[:post])
    end

    # Check that the current post is active and hasn't expired
    def check_active
      if (!@post.active? || @post.expired)
        render :inactive
      end
    end

    # Create a list of all the categories the trader is approved to sell in
    def approved_sell_categories
      @approved = ApprovedSellCat.where(trader_id: current_trader.id, status: 1)
      @approved_cat = Array.new(@approved.length)
      count = 0
      @approved.each do |f|
        @approved_cat[count] = f.sell_cat
        count = count + 1
      end
      return @approved_cat
    end

end
