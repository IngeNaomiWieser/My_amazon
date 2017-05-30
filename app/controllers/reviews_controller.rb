class ReviewsController < ApplicationController
  before_action :authenticate_user!      # No action will be executed until the user is signed in.

  def create
    @review = Review.new(review_params)
    @product = Product.find(params[:product_id])   # put this here, cause a review gets created for that particular product with that id
    @review.product = @product    #Now you say: this review belongs to this product. You also need 'belongs_to' in the model
    @review.user = current_user          #de user that makes the review is the logged in user. It gets an author so to say. (Also in the model)

    if cannot? :create, @review
      flash[:alert] = "Access denied. You cannot create a review for your own product!"
      redirect_to @product
    elsif @review.save
      flash[:notice] = 'Review created'
      redirect_to @product          # @product tells rails that we mean: product_path(@product) (showpage)
    else
      flash[:notice] = 'Problem creating review'
      render 'product/show'
    end
  end

  def destroy
    @product = Product.find params[:product_id]    # you need this cause you redirect it to the product showpage below
    @review = Review.find params[:id]
    @review.destroy
    redirect_to product_path(@product), notice: 'Review deleted'
  end

  private

  def review_params
    params.require(:review).permit(:rating, :body)
  end
end
