class CartItem < ApplicationRecord
  belongs_to :item
  belongs_to :user

  validates :how_many, presence: true, numericality: { :greater_than => 0 }

  def unit_price
    item.tax_included_price(item.price)
  end

  def subtotal_price
    unit_price * how_many
  end


end
