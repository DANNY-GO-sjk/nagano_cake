class CartItem < ApplicationRecord
  belongs_to :item
  belongs_to :user

  validates :how_many, presence: true # default 1 && 1 以上
end
