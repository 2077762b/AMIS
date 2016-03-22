class BidsController < ApplicationController

  # Create a new bid for the current post
  def create
    @bid = Bid.new(bid_params)
    @post = @bid.post

    # Check that the current bid is at least an increase of 1% on the previous bid
    if (@bid.amount && @bid.amount >= (@post.price + @post.price/100))

      # Get any previous highest bids and set them to false
      @previous = Bid.where(post: @post).where(highest_bid: true)
      @previous.each do |p|
        p.highest_bid = false
        p.save
      end

      # Set the current bid to highest
      @bid.highest_bid = true
      @bid.trader_id = current_trader.id
      @bid.save

      # Update the post with the new bid information
      @post.price = @bid.amount
      @post.no_of_bids = @post.no_of_bids + 1
      @post.highest_bidder = current_trader.id
      @post.save
      redirect_to post_path(@post), notice: 'Bid was successfully created.'
    else
      redirect_to post_path(@post),
                  notice: 'Bids must be at least 1% greater than previous bids (i.e. at least £' +
                      (@post.price + @post.price/100).round(2).to_s + ')'
    end

  end

  # Allows a trader to remove old outbid bids
  def destroy
    @bid = Bid.find(params[:id])
    # Check that the bid is not currently the highest bid in an auction
    if (@bid.highest_bid?)
      respond_to do |format|
        format.html { redirect_to profiles_path(current_trader.id), notice: 'Bid cannot be destroyed.' }
      end
    end
    # Otherwise destroy the bid
    @bid.destroy
    respond_to do |format|
      format.html { redirect_to profiles_path(current_trader.id), notice: 'Bid was successfully destroyed.' }
    end
  end

  # Set allowed parameters
  def bid_params
    params.require(:bid).permit(:post_id, :amount)
  end

end
