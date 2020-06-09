require 'rails_helper'

RSpec.describe "マスタ登録", type: :feature do
  before do
    # 管理者を作成する
    Admin.create!(email: 'foo@example.com', password: '123456')
  end

  describe '管理者' do
    context 'ログイン画面' do
      example '1' do
        # 管理者用ログインページを開く
        visit new_admin_session_path
        # メールアドレス・パスワードでログインする
        fill_in 'admin_email', with: 'foo@example.com'
        fill_in 'admin_password', with: '123456'
        # ログインボタンをクリックする
        click_button 'ログイン'
        # 管理者トップ画面が表示される
        expect(page).to have_content '管理者画面'
      end
    end

    describe "ログイン後" do
      before do
        # 管理者用ログインページを開く
        visit new_admin_session_path
        # ログインフォームにEmailとパスワードを入力する
        fill_in 'admin_email', with: 'foo@example.com'
        fill_in 'admin_password', with: '123456'
        # ログインボタンをクリックする
        click_button 'ログイン'
      end

      context '管理者トップ画面' do
        example '2' do
          # 管理者トップ画面を開く
          visit admins_home_path
          # ヘッダからジャンル一覧へのリンクを押下する
          click_on 'ジャンル一覧'
          # ジャンル一覧画面が表示される
          expect(page).to have_content 'ジャンル一覧・追加'
        end
      end

      context 'ジャンル一覧画面' do
        before do
          # genre一覧画面を開く
          visit admins_genres_path
        end

        example '3' do
          @genre = build(:genre)
          # 必要事項を入力し、
          fill_in 'genre_name', with: @genre.name
          choose 'genre_is_valid_有効'
          # 登録ボタンを押下する
          click_button '追加'
          # 追加したジャンルが表示されている
          expect(page).to have_content @genre.name
          # 登録に成功したことを検証する
          expect(Genre.count).to eq(1)
        end

        example '4' do
          # genre一覧画面を開く
          visit admins_genres_path
          # ヘッダから商品一覧へのリンクを押下する
          click_on '商品一覧'
          # 商品一覧画面が表示される
          expect(page).to have_content '商品一覧'
        end
      end

      context '商品一覧画面-商品新規登録画面-商品詳細画面' do
        before do
          @item = build(:item)
          @genre = create(:genre)
        end

        example '5,6,7,8' do
          # 商品一覧画面を開く
          visit admins_items_path
          # 新規登録ボタンをクリックする
          find(".item-new").click
          # 商品新規登録画面表示に成功したことを検証する
          expect(page).to have_content '商品新規登録'

          # 必要事項を入力して
          fill_in 'item_name', with: @item.name
          fill_in 'item_explanation', with: @item.explanation
          fill_in 'item_price', with: @item.price
          # セレクトボックスで値を指定する
          select @genre.name, from: 'item_genre_id'
          select @item.is_valid, from: 'item_is_valid'
          # 画像ファイルを指定する
          attach_file 'item_image', "#{Rails.root}/spec/factories/rails.png"
          # 登録ボタンを押下する
          click_button '新規登録'
          # 登録した商品の詳細画面に遷移する
          expect(page).to have_content '商品詳細'
          expect(page).to have_content @item.name
          # 商品が1つになっていることを検証する
          expect(Item.count).to eq(1)
          # 商品一覧をクリックする
          click_on '商品一覧'
          # 登録した商品が表示されている
          expect(page).to have_content '@item.name'
        end
      end

      context '商品一覧->商品新規登録->商品詳細画面->商品一覧' do
        before do
          @genre = create(:genre)
          @item1 = create(:item)
          @item2 = build(:item)
        end

        example '9,10,11,12' do
          # 商品一覧画面を開く
          visit admins_items_path
          # 新規登録ボタンをクリックする
          find(".item-new").click
          # 商品新規登録画面表示に成功したことを検証する
          expect(page).to have_content '商品新規登録'

          # 必要事項を入力して
          fill_in 'item_name', with: @item2.name
          fill_in 'item_explanation', with: @item2.explanation
          fill_in 'item_price', with: @item2.price
          # セレクトボックスで値を指定する
          select @genre.name, from: 'item_genre_id'
          select @item2.is_valid, from: 'item_is_valid'
          # 画像ファイルを指定する
          attach_file 'item_image', "#{Rails.root}/spec/factories/rails.png"
          # 登録ボタンを押下する
          click_button '新規登録'
          # 登録した商品の詳細画面に遷移する
          expect(page).to have_content '商品詳細'
          expect(page).to have_content @item2.name
          # 商品が2つになっていることを検証する
          expect(Item.count).to eq(2)
          # 商品一覧をクリックする
          click_on '商品一覧'
          # 商品一覧画面が表示される
          expect(page).to have_content '商品一覧'
          # 登録した商品が表示されている
          expect(page).to have_content @item2.name
        end
      end

      context '商品一覧' do
        example '13' do
          # 商品一覧画面を開く
          visit admins_items_path
          # ヘッダからログアウトボタンをクリックする
          click_on 'ログアウト'
          # 管理者ログイン画面に遷移する
          expect(page).to have_content '管理者ログイン'
        end
      end
    end
  end
end
