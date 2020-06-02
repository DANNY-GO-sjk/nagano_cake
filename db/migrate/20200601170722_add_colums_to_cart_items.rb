class AddColumnsToCartItems < ActiveRecord::Migration[5.2]
  def change
    add_reference :cart_items, :item, foreign_key: true
    add_reference :cart_items, :user, foreign_key: true
    add_column :cart_items, :how_many, :integer
  end
end
