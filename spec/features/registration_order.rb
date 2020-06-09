require 'rails_helper'

RSpec.describe "登録〜注文", type: :feature do
  before do
    # ユーザーを作成する
    @user1 = build(:user)
    # 商品を作成する
    @item = create(:item)
    # @item2 = create(:item)
    # ジャンルを作成する
    @genre = create(:genre)
  end

  context 'トップページ' do
    example '1' do
      # トップページを開く
      visit home_path
      # 新規登録画面へのリンクを押下する
      click_on '新規登録'
      # 新規登録画面が表示される
      expect(page).to have_content '新規会員登録'
    end
  end

  context '新規登録画面' do
    example '2,3' do
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
      fill_in 'user_password', with: @user1.password
      fill_in 'user_password_confirmation', with: @user1.password_confirmation
      # 登録ボタンを押下する
      click_button '新規登録'
      # トップ画面に遷移する
      expect(page).to have_content 'オススメ商品'
      # ヘッダがログイン後の表示に変わっている
      expect(page).to have_content 'ログアウト'
      expect(User.count).to eq(1)
    end
  end

  context 'ログイン後' do
    before do
      @user1 = create(:user)
      # ログイン画面を開く
      visit new_user_session_path
      # 必要事項を入力して
      fill_in 'user_email', with: @user1.email
      fill_in 'user_password', with: @user1.password
      # 登録ボタンを押下する
      click_button 'ログイン'
    end

    context 'トップ画面' do
      example '4,5' do
        # トップ画面を開く
        visit home_path
        # 商品画像をクリック
        find(".item-#{@item.id}-show").click
        # 該当商品の詳細画面に遷移する
        expect(page).to have_content '商品詳細'
        # 商品情報が正しく表示されている
        expect(page).to have_content @item.name
      end
    end

    context '商品詳細画面' do
      example '6,7' do
        # 商品詳細画面を開く
        visit item_path(@item)
        # 個数を選択し
        select 5, from: 'cart_item_how_many'
        # カートに入れるボタンを押下する
        click_button 'カートに入れる'
        # カート画面に遷移する
        expect(page).to have_content 'ショッピングカート'
        # カートの中身が正しく表示されている
        expect(page).to have_content @item.name
        expect(page).to have_content @item.tax_included_price(@item.price)
        expect(page).to have_content 5
        expect(page).to have_content @item.tax_included_price(@item.price) * 5
      end
    end

    context 'カート画面-トップ画面-商品詳細画面' do
      example '8,9,10' do
        # カート画面を開く
        visit cart_items_path
        # 買い物を続けるボタンを押下
        click_on '買い物を続ける'
        # トップ画面に遷移する
        expect(page).to have_content 'オススメ商品'
        # 任意の商品画像を押下する
        find(".item-#{@item.id}-show").click
        # 該当商品の詳細画面に遷移する
        expect(page).to have_content @item.name
        # 商品情報が正しく表示されている
        expect(page).to have_content @item.price
      end
    end

    context '商品詳細画面' do
      example '11,12' do
        rnd = rand(10) + 1
        # 商品詳細画面を開く
        visit item_path(@item)
        # 個数を選択し、
        select rnd, from: 'cart_item_how_many'
        # カートに入れるボタンを押下する
        click_button 'カートに入れる'
        # カート画面に遷移する
        expect(page).to have_content 'ショッピングカート'
        # カートの中身が正しく表示されている
        expect(page).to have_content @item.name
      end
    end

    # context 'カート画面' do
    #   before do
    #     @cart_item = create(:cart_item)
    #     @cart_item.update(user_id: @user1.id)
    #   end

    # example '13,14' do
    #   rnd = rand(10) + 10
    #   # カート画面を開く
    #   visit cart_items_path
    #   # 商品の個数を変更し、
    #   find(".cart_item-#{@cart_item.id}-how_many").set(rnd)
    #   # 更新ボタンを押下する
    #   find(".cart_item-#{@cart_item.id}-submit").click
    #   # 個数が変更されているか FIXME:変更されないバグあり
    #   expect(@cart_item.how_many).to eq(rnd)
    #   # 合計表示が正しく更新される
    #   # 小計表示が正しく更新される FIXME:ホントは合計
    #   expect(page).to have_content @cart_item.subtotal_price
    #   # 次に進むボタンを押下する
    #   click_button '情報入力に進む'
    #   # 情報入力画面に遷移する
    #   expect(page).to have_content '注文情報入力'
    # end
    # end

    context '注文情報入力画面-注文確認画面' do
      before do
        @cart_item1 = create(:cart_item)
        @cart_item2 = create(:cart_item)
        @cart_item1.update(user_id: @user1.id)
        @cart_item2.update(user_id: @user1.id)
        # 注文情報入力画面に遷移する
        visit new_order_path
      end

      example '15,16,17,18,19' do
        shipping_price = 800
        total_price = @cart_item1.subtotal_price + @cart_item2.subtotal_price + shipping_price
        # 支払方法を選択する
        choose '銀行振込'
        # 登録済みの自分の住所を選択する
        choose 'ご自身の住所'
        # 次に進むボタンを押下する
        click_button '確認画面へ進む'
        # 注文確認画面に遷移する
        expect(page).to have_content '注文情報確認'
        # 選択した商品、合計金額、配送方法などが表示されている
        expect(page).to have_content @cart_item1.name
        expect(page).to have_content total_price
        expect(page).to have_content '銀行振込'
        expect(page).to have_content @user1.address
        # 確定ボタンを押下する
        click_on '購入を確定する'
        expect(page).to have_content 'ご購入ありがとうございました'
      end
    end

    # context 'サンクスページ' do
    #   example '20' do
    #     # サンクスページに遷移する
    #     visit thanks_order_path
    #     # ヘッダのマイページへのリンクを押下する
    #     click_on 'マイページ'
    #     # マイページに遷移する
    #     expect(page).to have_content 'マイページ'
    #   end
    # end

    context 'マイページ' do
      example '21' do
        # マイページに遷移する
        visit users_path
        # 注文履歴一覧へのリンクを押下する
        find(".orders-index").click
        # 注文履歴一覧画面が表示される
        expect(page).to have_content '注文履歴一覧'
      end
    end

    context '注文履歴一覧画面' do
      before do
        @order = create(:order)
        @order.update(user_id: @user1.id)
      end

      example '22,23,24' do
        # 注文履歴一覧画面に遷移する
        visit orders_path
        # 先ほどの注文の詳細表示ボタンを押下する
        find(".order-#{@order.id} .show").click
        # 注文詳細画面が表示される
        expect(page).to have_content '注文履歴詳細'
        expect(page).to have_content @order.total_price
        expect(page).to have_content '入金待ち'
      end
    end
  end
end
