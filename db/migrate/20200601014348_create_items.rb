class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
	    t.integer "genre_id"
	    t.string "name"
	    t.integer "price"
	    t.string "image_id"
	    t.text "explanation"
	    t.boolean "is_valid", default: true, null: false

      t.timestamps
    end
  end
end
