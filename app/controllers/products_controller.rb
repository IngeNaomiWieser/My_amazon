class ProductsController < ApplicationController

  before_action :authenticate_user!, except: [:index, :show]

  def index
    @products = Product.all               #zie '@products in je view/product/index'. Dat wordt hier gedefinieerd.
  end

  def show
    @product = Product.find params[:id]
    @review = Review.new
  end

  def new              # you don't specify where it should render to, so it assumes it has to go to the vies/product/new
    @product = Product.new           #new is a get request
  end

  def create               #post request
    product_params = params.require(:product).permit(:title, :description, :price, :category_id)       #defining the params you permit
    @product = Product.new product_params      # @product is an instance variable that we can use in the views. Without @ the views don't know that you mean.
    @product.user = current_user               # Here you assign a user to the product. You get a user from the session.
    if @product.save                           # Als de validations goed zijn kun je saven. Dan
      flash[:notice] = 'Product created'
      redirect_to @product                     # products_path is the index-action from the products controller
    else
      flash[:alert] = 'Problem creating your product'
      render :new                              # niet gelukt om te saven, gaat terug naar dezelfde pagina and you keep the information
    end
  end

  def edit                                 #edit is get
    @product = Product.find params[:id]
    unless can? :edit, @product
      flash[:notice] = 'You cannot edit something that is not yours'
      redirect_to @product
    end
  end

  def update                               #update is patch (patch is a post)
    product_params = params.require(:product).permit(:title, :description, :price, :category_id)
    @product = Product.find params[:id]

    if cannot? :edit, @product
      flash[:alert] = "Access Denied. You cannot edit a product that is not yours"
      redirect_to @product
    elsif @product.update(product_params)
      redirect_to @product, notice: "Successfully Updated"
    else
      flash.now[:alert] = "Problem Updating"
      render :edit
      end
  end

  def destroy
    if can? :destroy, @product
      p = Product.find params[:id]
      p.destroy
      redirect_to @product, notice: 'Product deleted'
    else
      flash[:alert] = 'Access denied. You can not destroy it cause it is not yours.'
      redirect_to products_path
    end
  end

end
