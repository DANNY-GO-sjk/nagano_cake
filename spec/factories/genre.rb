FactoryBot.define do
  factory :genre do
    sequence(:name) { |n| "genre name #{n}" }
    sequence(:is_valid) { true }
  end
end
