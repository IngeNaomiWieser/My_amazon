class VotesController < ApplicationController
  before_action :find_review, only: [:create]
  before_action :find_vote, only: [:update, :destroy]

  def create
    vote = Vote.new(
      user: current_user,
      review: @review,
      is_up: params[:is_up]
    )

    if vote.save
      flash[:notice] = 'Thanks for voting!'
    else
      flash[:alert] = vote.pretty_errors
    end

    # as a shortcut, rails allows to redirect to an
    # instace of model instead of redirect_to question_path(@question)
    # this will only work if your routes follow rails convention
    redirect_to @review.product
  end

  def update
   if @vote.update is_up: params[:is_up]
     flash[:notice] = 'Vote Change!'
   else
     flash[:alert] = @vote.pretty_errors
   end

   redirect_to @vote.review.product
 end

 def destroy
   if @vote.destroy
     flash[:notice] = 'Vote removed'
   else
     flash[:alert] = @vote.pretty_errors
   end

   redirect_to @vote.review.product
 end

  private

  def find_review
    @review = Review.find(params[:review_id])
  end

  def find_vote
    @vote = Vote.find(params[:id])
  end

end
