class ProductsMailer < ApplicationMailer

  def notify_product_owner(product)
   @product = product
   @user = product.user
   if @user
     mail(to: 'ingewieser@gmail.com', subject: 'You created this product...')
   end
 end

end
