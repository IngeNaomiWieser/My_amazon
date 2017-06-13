class LikesController < ApplicationController
  before_action :authenticate_user! 

  def create
    # @product = Product.find(params[:product_id])
    like = Like.new
    review = Review.find params[:review_id]
    #below: the review that belongs to the like is the review I just found
    like.review = review
    #below: the user that belongs to the like is the current (logged in) user
    like.user = current_user
    if cannot? :like, review
      flash[:alert] = "You can not like your own review. That's lame."
    elsif like.save
      flash[:notice] = "Thanks for liking!"
    else
      flash[:alert] = like.errors.full_messages.join(', ')
    end
    redirect_to product_path(review.product)
  end

  def destroy
    # review = Review.find params[:review_id]
    like = current_user.likes.find params[:id]
    if like.destroy
      flash[:notice] = "Like removed"
    else
      flash[:alert] = like.pretty_errors
    end
    redirect_to product_path(like.review.product)
    # of als je de review bovenin 'aanzet' kun je doen : product_path(review.product)
  end
end
