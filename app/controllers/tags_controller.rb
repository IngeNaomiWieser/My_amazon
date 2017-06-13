class TagsController < ApplicationController

  def index
    @tags = Tag.all
    # @product = Product.find(params[:product_id])
  end

  def show
    @tag = Tag.find params[:id]
    @products = Product.joins(:taggings).where(taggings: {tag_id: @tag.id})
  end

end
