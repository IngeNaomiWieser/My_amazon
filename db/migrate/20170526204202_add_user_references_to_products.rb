class AddUserReferencesToProducts < ActiveRecord::Migration[5.1]
  def change
    add_reference :products, :user, foreign_key: true, index: true 
  end
end
