class PicturesController < ApplicationController

  # All actions require the trader to be authenticated
  before_action :authenticate_trader!
  before_action :set_picture, only: [:edit, :update]

  # Allows a trader to create a new profile picture
  def new
    @picture = Picture.new(hidden: 1)
  end

  # Allows a trader to edit their profile picture
  def edit
    @hidden = 2
  end

  # Create a new profile picture
  def create
    @picture = Picture.new(picture_params)
    current_trader.picture = @picture
    current_trader.save

    respond_to do |format|
      if @picture.save
        format.html { redirect_to profiles_path(current_trader.id), notice: 'Picture was successfully updated.' }
        format.json { render :show, status: :created, location: @picture }
      else
        format.html { render :new }
        format.json { render json: @picture.errors, status: :unprocessable_entity }
      end
    end
  end

  # Update a profile picture
  def update
    respond_to do |format|
      if @picture.update(picture_params)
        format.html { redirect_to profiles_path(current_trader.id), notice: 'Picture was successfully updated.' }
        format.json { render :show, status: :ok, location: @picture }
      else
        format.html { render :edit }
        format.json { render json: @picture.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Get the current picture and check that the user trying to edit it is the user that owns it
    def set_picture
      @picture = Picture.find(params[:id])
      if (current_trader.picture.id != @picture.id)
        render :not_permitted
      end
    end

    # Set allowed parameters
    def picture_params
      params.require(:picture).permit(:image, :hidden)
    end
end
