FactoryBot.define do
  factory :order do
    user
    progress { 0 }
    shipping_price { 800 }
    payment_method { rand(2) }
    postcode { Faker::Number.number(digits: 7) }
    address { Faker::Address.city }
    receiver { Faker::Name.name }
    total_price { 0 }
    order_items do
      [
        FactoryBot.build(:order_item, order: nil),
      ]
    end
    after(:build) do |order|
      order.order_items.each do |order_item|
        order.total_price += order_item.price * order_item.how_many
      end
      order.total_price += order.shipping_price
    end
  end
end
