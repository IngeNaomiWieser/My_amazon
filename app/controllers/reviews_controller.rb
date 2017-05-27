class ReviewsController < ApplicationController
before_action :authenticate_user!

  def index
  end

  def show
  end

  def edit
  end

  def create
    @review = Review.new(review_params)
    @product = Product.find(params[:product_id])
    @review.product = @product
    @review.user = current_user          # testen
    if @review.save
      flash[:notice] = 'Review created'
      redirect_to @product
    else
      flash[:notice] = 'Problem creating review'
      render 'product/show'
    end
  end

  def update
  end

  def destroy
    @product = Product.find params[:product_id]
    @review = Review.find params[:id]
    @review.destroy
    redirect_to product_path(@product), notice: 'Review deleted'
  end

  private

  def review_params
    params.require(:review).permit(:rating, :body)
  end
end
