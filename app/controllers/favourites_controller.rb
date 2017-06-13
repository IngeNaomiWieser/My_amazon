class FavouritesController < ApplicationController
before_action :authenticate_user!, only: [:create, :destroy]

  def create
    @product = Product.find(params[:product_id])
    @favourite = Favourite.new(product: @product, user: current_user)
    # or: favourite = current_user.favourites.new(product: @product)
    # or: favourite = @product.favourites.new(user: current_user)
    if cannot? :favourite, @product
      flash[:alert] = "Sorry, you can not favourite your own product"
    elsif @favourite.save
      flash[:notice] = 'Favourited'
    else
      flash[:alert] = 'Problem favouriting'
    end
    redirect_to product_path(@product)
  end


  def destroy
    @favourite = current_user.favourites.find(params[:id])
    # or: @product = Product.find(params[:product_id])
    if cannot? :favourite, @favourite.product
      flash[:alert] = 'You can not un-favourite your own product'
    elsif @favourite.destroy
      flash[:notice] = 'Unfavourited'
    else
      flash[:alert] = 'Problem removing the favourite'
    end
    redirect_to product_path(@favourite.product)
  end

end
