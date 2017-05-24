class AddHitCountToProducts < ActiveRecord::Migration[5.1]
  def change
        add_column :products, :hit_count, :integer
  end
end
