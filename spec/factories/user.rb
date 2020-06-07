FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "user#{n}@test.com" }
    sequence(:family_name) { |n| "family_name#{n}" }
    sequence(:first_name) { |n| "first_name#{n}" }
    sequence(:family_name_yomi) { |n| "family_name_yomi#{n}" }
    sequence(:first_name_yomi) { |n| "first_name_yomi#{n}" }
    sequence(:postcode) { |n| "100811#{n}" }
    sequence(:address) { |n| "東京都千代田区千代田１−#{n}" }
    sequence(:phone_number) { |n| "0901111222#{n}" }
    sequence(:is_valid) { true }
    password { 'testtest' }
    password_confirmation { 'testtest' }
  end
end
