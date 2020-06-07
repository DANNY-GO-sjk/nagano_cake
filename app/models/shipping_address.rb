class ShippingAddress < ApplicationRecord
  def full_text
    "#{postcode} #{address} #{receiver}"
  end
end
