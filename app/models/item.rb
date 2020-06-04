class Item < ApplicationRecord
	has_many :carts
	has_many :order_items
	belongs_to :genre
	enum is_valid: {販売中: true,　販売停止中: false}

	validates :name, presence: true
	validates :explanation, presence: true
	validates :price, presence: true
	validates :image, presence: true

	attachment :image

	def tax_included_price(price)
		price * 1.08
	end
end
