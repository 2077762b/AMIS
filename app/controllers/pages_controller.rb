class PagesController < ApplicationController

  before_action :authenticate_trader!, only: [:feedback, :profile, :approved]

  # Get the top 9 posts for the home page
  def home
    @posts = Post.order("views DESC").limit(9)
  end

  # Get the following information for profile page
  def profile
    # Current logged in trader
    @current = current_trader
    # Trader whose profile page it is
    @trader = Trader.find(params[:id])
    # All active buy it now posts (newest first)
    @posts = Post.where(trader_id: @trader.id).where(active:true).where(auction:false).order(created_at: :desc)
    # All active auction posts (newest first)
    @auctions = Post.where(trader_id: @trader.id).where(active:true).where(auction:true).order(created_at: :desc)
    # All auctions the trader is currently winning
    @winning_auctions = Post.where(active:true).where(auction:true).where(highest_bidder: @trader.id)
    # All bids the trader has made
    @bids = Bid.where(trader_id: current_trader)
    # All items the trader has sold (newest first)
    @sold = Trade.all.order(time: :desc).select { |m| m.post.trader == @trader}
    # All items the trader has bought (newest first)
    @bought = Trade.where(trader_id: @trader.id).order(time: :desc)
    # All samples that the trader has had requested of them
    @requested_samples = Request_Sample.where(seller_id: @trader.id).select { |m| m.post.trader == @trader}
    # All categories the trader is approved to buy in
    @approvedBuy = ApprovedBuyCat.where(trader_id: @trader.id).where(status: '1')
    # All categories the trader is approved to sell in
    @approvedSell = ApprovedSellCat.where(trader_id: @trader.id).where(status: '1')
    # The overall rating of the trader
    ratings = Trade.includes(:post).where(posts: { trader_id: @trader.id} ).collect{|m| m.rating.to_i}.compact
    length = ratings.collect{|m| if m != 0
                                   m
                                 end}.compact.length

    @rating = ratings.sum.to_f / (length == 0? 1 : length)
    if @rating == nil
      @rating = 0
    end
  end

  # No information required for about us page
  def about_us
  end

  # Get the current trader to use to generate a page showing all the buy/sell subcategories
  # and the status of that trader in that category
  def approved
    @trader = current_trader
  end

  # Updates the trades feedback
  def feedback
    @trader = current_trader
    @trade = Trade.find(params[:formid].to_i)
    if @trade.trader_id == @trader.id
      @trade.feedback = params[:content]
      if params[:rating] <= "5"
        @trade.rating = params[:rating]
      end
      @trade.rating = params[:rating]
      @trade.save
      render :text => @trade.feedback
    else
      render :text => "Whatever you need to response"
    end
  end

  # Data required to generate the statistics page
  def statistics

    # Number of trades that were carried out in each category
    @subcategories = Subcategory.all
    @trades_per_cat = Array.new(2){Array.new(Subcategory.all.count)}
    count = 0
    @subcategories.each do |s|
      @trades_per_cat[count] = [s.name.split.first,Post.where(active: 'false').where(subcategory_id: s.id).size]
      count = count + 1
    end

    # The total cost of items sold in each category
    @total_value_per_cat = Array.new(2){Array.new(Subcategory.all.count)}
    count = 0
    @subcategories.each do |s|
      @posts = Post.where(active: 'false').where(subcategory_id: s.id)
      total = 0
      @posts.each do |p|
        total = total + p.price
      end
      @total_value_per_cat[count] = [s.name.split.first,total.round(2)]
      count = count + 1
    end

    # The average cost of items sold in each cateogry
    @average_value_per_cat = Array.new(2){Array.new(Subcategory.all.count)}
    count = 0
    @subcategories.each do |s|
      @posts = Post.where(active: 'false').where(subcategory_id: s.id)
      num = @posts.count
      total = 0
      @posts.each do |p|
        total = total + p.price
      end
      @average_value_per_cat[count] = [s.name.split.first,(total/num).round(2)]
      count = count + 1
    end

    # The max cost item per category
    @max_cost_per_cat = Array.new(2){Array.new(Subcategory.all.count)}
    count = 0
    @subcategories.each do |s|
      @posts = Post.where(active: 'false').where(subcategory_id: s.id)
      max = 0
      @posts.each do |p|
        if p.price > max
          max = p.price
        end
      end
      @max_cost_per_cat[count] = [s.name.split.first,max.round(2)]
      count = count + 1
    end
  end

end
