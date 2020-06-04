class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.references  :genre, foreign_key: true
      t.string      :name, null: false
      t.integer     :price, null: false
      t.string      :image_id # null: false
      t.text        :explanation # null: false
      t.boolean     :is_valid, null: false, default: true
      t.timestamps
    end
  end
end
