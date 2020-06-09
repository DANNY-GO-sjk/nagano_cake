class ShippingAddress < ApplicationRecord
  def full_address
    "#{postcode} #{address} #{receiver}"
  end
end
