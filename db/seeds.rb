# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# 追記
Admin.create!(
   email: 'nagano_cake@test.com',
   password: 'testtest',
)

User.create!(
   email: 'user@test.com',
   password: 'testtest',
   family_name: '長野',
   first_name: '太郎',
   family_name_yomi: 'ナガノ',
   first_name_yomi: 'タロウ',
   postcode: '1008111',
   address: '東京都千代田区千代田１−１',
   phone_number: '09011112222',
   is_valid: true,
)

Genre.create!(
   name: '焼き菓子',
   is_valid: true,
)

Item.create!(
   name: 'ケーキ',
   genre_id: 1,
   price: 500,
   explanation: '商品説明文が入ります',
   is_valid: true,
)