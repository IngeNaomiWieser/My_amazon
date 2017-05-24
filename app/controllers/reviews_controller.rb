class ReviewsController < ApplicationController
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
  end

  private

  def review_params
    params.require(:review).permit(:rating, :body)
  end
end
