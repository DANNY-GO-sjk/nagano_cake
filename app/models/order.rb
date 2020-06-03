class Order < ApplicationRecord
  belongs_to :user
  has_many :items
  has_many :order_items, dependent: :destroy
  has_many :shipping_addresses, dependent: :destroy

  validates :progress, presence: true
  validates :shipping_price, presence: true
  validates :total_price, presence: true
  validates :payment_method, presence: true
  validates :postcode, presence: true
  validates :address, presence: true
  validates :receiver, presence: true

  enum payment_method: { credit_card: 0, bank_transfer: 1 }
end
