class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.references  :user,           null: false, foreign_key: true
      t.integer     :progress,       null: false, default: 0
      t.integer     :shipping_price, null: false, default: 800
      t.integer     :total_price,    null: false
      t.integer     :payment_method, null: false, default: 0
      t.string      :postcode,       null: false
      t.string      :address,        null: false
      t.string      :receiver,       null: false

      t.timestamps
    end
  end
end
