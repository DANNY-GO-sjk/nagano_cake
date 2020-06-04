class CreateOrderItems < ActiveRecord::Migration[5.2]
  def change
    create_table :order_items do |t|
      t.references :order,    null: false, foreign_key: true
      t.references :item,     null: false, foreign_key: true
      t.integer    :how_many, null: false
      t.integer    :price,    null: false
      t.integer    :progress, null: false, default: 0

      t.timestamps
    end
  end
end
