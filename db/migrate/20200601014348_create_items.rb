class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.integer :genre_id, foreign_key: true
      t.string :name
      t.integer :price
      t.string :image_id
      t.text :explanation
      t.boolean :is_valid, null: false, default: true

      t.timestamps
    end
  end
end
