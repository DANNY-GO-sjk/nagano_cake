class Order < ApplicationRecord
  belongs_to :user
  has_many :items
  has_many :order_items, dependent: :destroy

  validates :progress, presence: true
  validates :shipping_price, presence: true
  validates :total_price, presence: true
  validates :payment_method, presence: true
  validates :postcode, presence: true
  validates :address, presence: true
  validates :receiver, presence: true

  enum payment_method: { クレジットカード: 0, 銀行振込: 1 }
  enum progress: { 入金待ち: 0, 入金確認: 1, 製作中: 2, 発送準備中: 3, 発送済: 4 }

  # FIX: shipping_addressでバリデーションしたほうが良い。
  def has_shipping_address?
    return false if postcode.blank?
    return false if address.blank?
    return false if receiver.blank?
    true
  end


end
