class Admin::PanelController < Admin::BaseController

  def index
    @products = Product.count
    @reviews = Review.count
    @users = User.count
  end

end
