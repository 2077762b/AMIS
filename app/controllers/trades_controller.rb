class TradesController < ApplicationController

  # Include the neccessary files to talk to paypal
  require 'paypal-sdk-rest'
  include PayPal::SDK::REST
  include PayPal::SDK::Core::Logging

  # A trader must be logged in for all the following actions
  before_action :authenticate_trader!

  # Prevents a user from buying items they are not permitted to
  before_action :check_user, only: [:paypal]

  # Shows the details of a completed trade
  def show
    @trade = Trade.find(params[:id])
    @post = @trade.post
    # Will only display the trade details if the current trader is the buyer, the seller or an admin user
    if (@post.trader == current_trader || @trade.trader == current_trader || current_trader.admin?)
      render :show
    else
      render :not_permitted
    end
  end

  # Allows a buyer to pay for an item
  def paypal
    # Create a new payment
    @payment = Payment.new({
                               # Indicates that the payment should be completed on Paypal
                               :intent =>  "sale",
                               :payer =>  {
                                   :payment_method =>  "paypal" },

                               # The addresses that Paypal will return to following a successful and failed payment
                               :redirect_urls => {
                                   :return_url => "http://localhost:3000/paypal/execute",
                                   :cancel_url => "http://localhost:3000/" },

                               # Details of the item to be paid for
                               :transactions =>  [{
                                                      :item_list => {
                                                          :items => [{
                                                                         :name => @post.name,
                                                                         :sku => @post.description,
                                                                         :price => '%.2f' % @post.price,
                                                                        :currency => "GBP",
                                                                         :quantity => 1 }]},
                                                      :amount =>  {
                                                          :total => '%.2f' % @post.price,
                                                          :currency =>  "GBP" },
                                                      :description =>  "Item bought on AMIS" }]})

    # Create the Payment and return the status
    if @payment.create
      # Redirect the user to given approval url
      @redirect_url = @payment.links.find{|v| v.method == "REDIRECT" }.href
      logger.info "Payment[#{@payment.id}]"
      logger.info "Redirect: #{@redirect_url}"
    else
      logger.error @payment.error.inspect
    end

    # Temporarily save the payment details
    ENV["PAYMENT_ID"] = @payment.id
    ENV["POST"] = @post.id.to_s
    redirect_to @redirect_url
  end

  # Execute a created payment
  def execute

    # Get payment details
    @payer_id  = params["PayerID"]
    @post = Post.find(ENV["POST"].to_i)
    @payment_id = ENV["PAYMENT_ID"]
    @payment = Payment.find(@payment_id)

    # Execute the payment and return status
    if @payment.execute( :payer_id => @payer_id )

      # if successful create a new trade
      logger.info "Payment[#{@payment.id}] execute successfully"
      @trade = Trade.new()
      @trade.trader_id = current_trader.id
      @trade.time = Time.now
      @trade.post = @post

      # Get the shipping address from the payment information
      @shipping = @payment.payer.payer_info.shipping_address
      @trade.line1 = @shipping.line1
      @trade.city =  @shipping.city
      @trade.county = @shipping.state
      @trade.postcode = @shipping.postal_code
      @trade.save

      # Change the post to inactive
      @trade.post.active = false
      @trade.post.save
      render :success
    else
      # Payment was not successful
      logger.error @payment.error.inspect
      render :fail
    end

  end

  private

    # Checks if the post is in an approved category of the buyer and
    # Also checks that the post has not previously been bought and
    # if it is an auction, that it has expired and that the current trader is the highest bidder
    def check_user
      @post = Post.find(params[:post])
      @in_buy_cat = ApprovedBuyCat.where(trader_id: current_trader.id).where(status: "1").exists?(:buy_cat_id => @post.subcategory_id)
      if (@post.active == 'false' || !@in_buy_cat || (@post.auction && (@post.expired == 'false' || @post.highest_bidder != current_trader.id)))
        render :not_permitted
      end
    end
end
