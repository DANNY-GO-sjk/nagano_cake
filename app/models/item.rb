class Item < ApplicationRecord
	validates :name, presence:true
	validates :price, presence:true
	validates :image, presence: true
	validates :genre, presence: true
	validates :is_valid, inclusion: { in: [true, false]}
	# is_validカラムに入れる値を制限する（true,false)

	belongs_to :genre
	attachment :image

	has_many :carts
	has_many :order_items
end
