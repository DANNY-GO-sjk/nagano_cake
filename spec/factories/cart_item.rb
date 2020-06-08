FactoryBot.define do
  factory :cart_item do
    user
    item
    how_many { rand(10) + 1 }
  end
end
