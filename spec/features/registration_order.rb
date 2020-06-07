require 'rails_helper'

RSpec.describe "登録〜注文", type: :feature do
  before do
    # ユーザーを作成する
    @user1 = build(:user)
    # 商品を作成する
    @item1 = create(:item)
    # @item2 = create(:item)
    # ジャンルを作成する
    @genre = create(:genre)
  end

  context 'トップページ' do
    example '新規登録画面へのリンクを押下する=>新規登録画面が表示される' do
      # トップページを開く
      visit home_path
      # 新規登録画面へのリンクを押下する
      click_on '新規登録'
      # 新規登録画面が表示される
      expect(page).to have_content '新規会員登録'
    end
  end

  context '新規登録画面' do
    example '必要事項を入力して登録ボタンを押下する=>トップ画面に遷移する・ヘッダがログイン後の表示に変わっている' do
      # 新規登録画面を開く
      visit new_user_registration_path
      # 必要事項を入力して
      fill_in 'user_family_name', with: @user1.family_name
      fill_in 'user_first_name', with: @user1.first_name
      fill_in 'user_family_name_yomi', with: @user1.family_name_yomi
      fill_in 'user_first_name_yomi', with: @user1.first_name_yomi
      fill_in 'user_postcode', with: @user1.postcode
      fill_in 'user_address', with: @user1.address
      fill_in 'user_phone_number', with: @user1.phone_number
      fill_in 'user_email', with: @user1.email
      fill_in 'user_password', with: 'testtest'
      fill_in 'user_password_confirmation', with: 'testtest'
      # 登録ボタンを押下する
      click_button '新規会員登録' # FIXME:本当は"新規登録"
      # トップ画面に遷移する
      expect(page).to have_content 'ようこそ'
      # ヘッダがログイン後の表示に変わっている
      expect(page).to have_content 'ログアウト'
      expect(User.count).to eq(1)
    end
  end
end
