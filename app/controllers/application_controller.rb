class ApplicationController < ActionController::Base

  before_action :configure_devise_permitted_parameters, if: :devise_controller?
  before_action :every_page

  # Before loading every page:
  def every_page

    # Get all categories and subcategories for category bar
    @categories= Category.all
    @subcategories = Subcategory.all

    # Check to see if any auctions are over 7 days old and change them to expired
    @check_posts = Post.where(auction: true).where(expired: false)
    @check_posts.each do |p|
      if (p.created_at + 7.days).past?
        p.expired = true
        p.save
      end
    end

    # Check if the current trader has any outstanding auctions to pay for
    if params[:action] != "paypal" && params[:action] != "execute" && trader_signed_in? &&
      @post = Post.where(auction: true).where(expired: true).
          where(active: true).where(highest_bidder: current_trader.id).first
      if (@post)
        render :auctions
      end
    end

  end

  # Redirect to profile page after sign in/ sign up
  def after_sign_in_path_for(resource)
    profiles_path(@trader.id)
  end
  def after_sign_up_path_for(resource)
    profiles_path(@trader.id)
  end

  protected

  # Set allowed parameters for devise registration
  def configure_devise_permitted_parameters
    registration_params = [:username, :email, :password, :password_confirmation, :image, :description]

    if params[:action] == 'update'
      devise_parameter_sanitizer.for(:account_update) { 
        |u| u.permit(registration_params << :current_password, registration_params << :description)
      }
    elsif params[:action] == 'create'
      devise_parameter_sanitizer.for(:sign_up) { 
        |u| u.permit(registration_params) 
      }
    end
  end

end