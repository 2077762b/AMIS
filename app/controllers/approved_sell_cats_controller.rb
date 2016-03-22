class ApprovedSellCatsController < ApplicationController

  # All actions require the trader to be authenticated
  before_filter :authenticate_trader!
  before_action :set_approved_sell_cat, only: [:edit, :update]

  # Allow trader to make to a new application to get approved to sell in a category
  def new
    @approved_sell_cat = ApprovedSellCat.new(sell_cat_id: params[:subcategory_id])
  end

  # Allows a trader to re apply to get approved to sell in a category
  def edit
    @sell_cat_id = @approved_sell_cat.sell_cat_id
  end

  # Create a new sell category application that has status '2'(pending)
  def create
    @approved_sell_cat = ApprovedSellCat.new(approved_sell_cat_params)
    @approved_sell_cat.status = '2'
    @approved_sell_cat.trader = current_trader
    @approved_sell_cat.save

    respond_to do |format|
      if @approved_sell_cat.save
        format.html { redirect_to approved_path, notice: 'An application was successfully made' }
      else
        format.html { render :new }
      end
    end
  end

  # Update an application with new evidence. Set status to pending.
  def update
    respond_to do |format|
      if @approved_sell_cat.update(approved_sell_cat_params)
        @approved_sell_cat.status = '2'
        @approved_sell_cat.save
        format.html { redirect_to approved_path, notice: 'An application was successfully made.' }
      else
        format.html { render :edit }
      end
    end
  end

  private
    # Get the corresponding sell category application
    def set_approved_sell_cat
      @approved_sell_cat = ApprovedSellCat.find(params[:id])
    end

    # Set allowed parameters
    def approved_sell_cat_params
      params.require(:approved_sell_cat).permit(:sell_cat_id, :document)
    end
end
