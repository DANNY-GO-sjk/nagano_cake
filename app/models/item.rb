class Item < ApplicationRecord
  has_many :carts
  has_many :order_items
  belongs_to :genre
  enum is_valid: { 販売中: true, 　販売停止中: false }

  validates :name, presence: true
  validates :explanation, presence: true
  validates :price, presence: true
  # 画像設定の手間を省くため一時的にコメントアウトします。Mr.
  # validates :image, presence: true

  # attachment :image
end
