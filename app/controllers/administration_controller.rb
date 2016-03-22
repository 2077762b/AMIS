class AdministrationController < ApplicationController

  before_filter :authenticate_trader!
  before_filter :is_admin?

  # checks if the user currently logged in is an admin user before any of the
  # methods in this controller are executed
  def is_admin?
    if current_trader.admin?
      true
    else
      render :text => "Not allowed"
    end
  end

  # Gets all the pending approval applications
  def approval
    @buy_approvals = ApprovedBuyCat.where(status: '2')
    @sell_approvals = ApprovedSellCat.where(status: '2')
  end

  # Approve an application by a trader to buy in a particular category
  def approveBuy
    @update = ApprovedBuyCat.find(params[:update])
    # (status '1' means approved)
    @update.status = '1'
    @update.save
    redirect_to approval_path
  end

  # Decline an application by a trader to buy in a particular category
  def declineBuy
    @update = ApprovedBuyCat.find(params[:update])
    # (status '3' means declined)
    @update.status = '3'
    @update.save
    redirect_to approval_path
  end

  # Approve an application by a trader to sell in a particular category
  def approveSell
    @update = ApprovedSellCat.find(params[:update])
    # (status '1' means approved)
    @update.status = '1'
    @update.save
    redirect_to approval_path
  end

  # Decline an application by a trader to sell in a particular category
  def declineSell
    @update = ApprovedSellCat.find(params[:update])
    # (status '3' means declined)
    @update.status = '3'
    @update.save
    redirect_to approval_path
  end

  # Get all the posts that have been reported
  def reported
    @reported = Post.where(report: true)
  end

  # Admin can dismiss a reported post that has not broken any guidelines
  def dismiss
    @post = Post.find(params[:post])
    @post.report = false
    @post.save
    redirect_to reported_path
  end

  # Admin can delete a reported post that is found to break the applications guidelines
  def delete
    @post = Post.find(params[:post])
    @post.destroy
    redirect_to reported_path
  end

  # Get all completed trades to display those that need delivery
  def delivery
    @trades = Trade.all
  end

  # Allows an outstanding delivery to be dismissed once it has been completed
  def deliveryDismiss
    @post = Post.find(params[:post])
    @post.delivery = true
    @post.save
    redirect_to delivery_path
  end

  # Get all completed trades
  def completed
    @trades = Trade.all
  end

  # View the evidence that the seller in a trade provided showing that they were eligible to do so
  def seller
    @subcategory = Subcategory.find(params[:subcategory] )
    @trader = Trader.find(params[:trader])
    @approved = ApprovedSellCat.where(trader_id: @trader.id).where(sell_cat_id: @subcategory.id).first
    redirect_to @approved.document.url(:original, false)
  end

  # View the evidence that the buyer in a trade provided showing that they were eligible to do so
  def buyer
    @subcategory = Subcategory.find(params[:subcategory] )
    @trader = Trader.find(params[:trader])
    @approved = ApprovedBuyCat.where(trader_id: @trader.id).where(buy_cat_id: @subcategory.id).first
    redirect_to @approved.document.url(:original, false)
  end

  # Export all the completed trades to excel
  def export
    @trades = Trade.all
    @p = Axlsx::Package.new
    @wb = @p.workbook
    @wb.add_worksheet(name: "Completed Trades") do |sheet|
      sheet.add_row ["Name", "Category", "Quantity", "Price(£)", "Completed", "Seller Name","Buyer Name"],:b => true
      sheet.column_widths 15, 15, 15, 15, 15, 15
      @trades.each do |t|
        sheet.add_row [t.post.name,t.post.subcategory.name, t.post.quantity,
                       t.post.price,
                       (t.time).strftime("%H:%M %d/%m/%y"),
                       t.post.trader.username,t.trader.username ]
      end
    end
    @p.serialize("#{Rails.root}/tmp/completedTrades.xlsx")
    send_file("#{Rails.root}/tmp/completedTrades.xlsx", filename: "CompletedTrades.xlsx", type: "application/xlsx")
  end

end