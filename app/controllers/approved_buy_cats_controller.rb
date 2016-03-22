class ApprovedBuyCatsController < ApplicationController

  # All actions require the trader to be authenticated
  before_filter :authenticate_trader!
  before_action :set_approved_buy_cat, only: [:edit, :update]

  # Allow trader to make to a new application to get approved to buy in a category
  def new
    @approved_buy_cat = ApprovedBuyCat.new(buy_cat_id: params[:subcategory_id])
  end

  # Allows a trader to re apply to get approved to buy in a category
  def edit
    @buy_cat_id = @approved_buy_cat.buy_cat_id
  end

  # Create a new buy category application that has status '2'(pending)
  def create
    @approved_buy_cat = ApprovedBuyCat.new(approved_buy_cat_params)
    @approved_buy_cat.status = '2'
    @approved_buy_cat.trader = current_trader
    @approved_buy_cat.save

    respond_to do |format|
      if @approved_buy_cat.save
        format.html { redirect_to approved_path, notice: 'An application was successfully made' }
      else
        format.html { render :new }
      end
    end
  end

  # Update an application with new evidence. Set status to pending.
  def update
    respond_to do |format|
      if @approved_buy_cat.update(approved_buy_cat_params)
        @approved_buy_cat.status = '2'
        @approved_buy_cat.save
        format.html { redirect_to approved_path, notice: 'An application was successfully made.' }
      else
        format.html { render :edit }
      end
    end
  end

  private
    # Get the corresponding buy category application
    def set_approved_buy_cat
      @approved_buy_cat = ApprovedBuyCat.find(params[:id])
    end

    # Set allowed parameters
    def approved_buy_cat_params
      params.require(:approved_buy_cat).permit(:buy_cat_id, :document)
    end
end
