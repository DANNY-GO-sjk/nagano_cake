FactoryBot.define do
  factory :item do
    genre
    sequence(:name) { |n| "item name #{n}" }
    sequence(:price) { Faker::Number.number(digits: 3) }
    sequence(:image_id) { 1 }
    sequence(:explanation) { |n| "商品説明文 #{n}" }
    sequence(:is_valid) { true }
  end
end