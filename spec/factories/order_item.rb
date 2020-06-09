FactoryBot.define do
  factory :order_item do
    order
    item
    how_many { Faker::Number.number(digits: 1) }
    price { Faker::Number.number(digits: 3) }
    progress { 0 }
  end
end
