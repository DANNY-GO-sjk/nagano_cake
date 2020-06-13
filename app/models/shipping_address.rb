class ShippingAddress < ApplicationRecord
  belongs_to :user

  validates :postcode, presence: true, numericality: { only_integer: true }, length: { is: 7 }
  validates :address, presence: true
  validates :receiver, presence: true
  def full_address
    "#{postcode} #{address} #{receiver}"
  end
end
