FactoryBot.define do
  factory :cart_item do
    user
    item
    how_many { Faker::Number.number(digits: 1) }
  end
end
