FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "user#{n}@test.com" }
    sequence(:family_name) { Faker::Name.last_name }
    sequence(:first_name) { Faker::Name.first_name }
    sequence(:family_name_yomi) { "family_name_yomi" }
    sequence(:first_name_yomi) { "first_name_yomi" }
    sequence(:postcode) { Faker::Number.number(digits: 7) }
    sequence(:address) { Faker::Address.city }
    sequence(:phone_number) { Faker::PhoneNumber.phone_number }
    sequence(:is_valid) { true }
    password { 'testtest' }
    password_confirmation { 'testtest' }
  end
end
