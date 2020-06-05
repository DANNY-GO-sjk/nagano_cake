class CartItem < ApplicationRecord
  belongs_to :item
  belongs_to :user

  validates :how_many, presence: true, numericality: { :greater_than => 0 }
end
