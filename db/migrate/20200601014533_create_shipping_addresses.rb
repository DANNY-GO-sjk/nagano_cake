class CreateShippingAddresses < ActiveRecord::Migration[5.2]
  def change
    create_table :shipping_addresses do |t|
      t.string :user_id, foreign_key: true
      t.string :postcode, null: false
      t.string :address, null: false
      t.string :receiver, null: false



      t.timestamps
    end
  end
end
