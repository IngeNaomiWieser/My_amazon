class Admin::PanelController < Admin::BaseController

  def index
    @products_count = Product.count
    @reviews_count = Review.count
    @users_count = User.count
    @users = User.order(created_at: :desc)
    @products = Product.order(created_at: :desc)
  end

end
