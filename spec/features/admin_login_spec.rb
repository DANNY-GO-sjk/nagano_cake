require 'rails_helper'

RSpec.describe "マスタ登録", type: :feature do
  before do
    # 管理者を作成する
    Admin.create!(email: 'foo@example.com', password: '123456')
  end

  describe '管理者' do
    context 'ログイン画面' do
      example 'メールアドレス・パスワードでログインする=>管理者トップ画面が表示される' do
        # 管理者用ログインページを開く
        visit new_admin_session_path
        # ログインフォームにEmailとパスワードを入力する
        fill_in 'admin_email', with: 'foo@example.com'
        fill_in 'admin_password', with: '123456'
        # ログインボタンをクリックする
        click_button 'ログイン'
        # ログインに成功したことを検証する
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
        example 'ヘッダからジャンル一覧へのリンクを押下する=>ジャンル一覧画面が表示される' do
          # 管理者トップ画面を開く
          visit admins_home_path
          # ログインボタンをクリックする
          click_on 'ジャンル一覧'
          # ログインに成功したことを検証する
          expect(page).to have_content 'ジャンル一覧・追加'
        end
      end

      context 'ジャンル一覧画面' do
        example '必要事項を入力し、登録ボタンを押下する=>追加したジャンルが表示されている' do
          @genre = build(:genre)
          # genre一覧画面を開く
          visit admins_genres_path
          # フォームにnameを入力する
          fill_in 'genre_name', with: @genre.name
          # 有効ボタンにチェックする
          choose 'genre_is_valid_有効'
          click_button '追加'
          # 登録に成功したことを検証する
          expect(page).to have_content @genre.name
          expect(Genre.count).to eq(1)
        end

        example 'ヘッダから商品一覧へのリンクを押下する=>商品一覧画面が表示される' do
          # genre一覧画面を開く
          visit admins_genres_path
          # 商品一覧ボタンをクリックする
          click_on '商品一覧'
          # 商品一覧画面表示に成功したことを検証する
          expect(page).to have_content '商品一覧'
        end
      end

      context '商品一覧画面' do
        example '新規登録ボタンを押下する=>商品新規登録画面が表示される' do
          # 商品一覧画面を開く
          visit admins_items_path
          # 新規登録ボタンをクリックする
          click_on '+' # FIX ME: 本当はIDとかで管理したい
          # 商品新規登録画面表示に成功したことを検証する
          expect(page).to have_content '商品新規登録'
        end
      end

      context '商品新規登録画面' do
        example '必要事項を入力して登録ボタンを押下する=>登録した商品の詳細画面に遷移する' do
          @item = build(:item)
          @genre = create(:genre)
          # 商品新規登録画面を開く
          visit new_admins_item_path
          # フォームに値を入力する
          fill_in 'item_name', with: @item.name
          fill_in 'item_explanation', with: @item.explanation
          fill_in 'item_price', with: @item.price
          # セレクトボックスで値を指定する
          select @genre.name, from: 'item_genre_id'
          select @item.is_valid, from: 'item_is_valid'
          # 画像ファイルを指定する
          attach_file 'item_image', "#{Rails.root}/spec/factories/rails.png"
          # 新規登録ボタンをクリックする
          click_button '新規登録'
          # 詳細画面遷移に成功したことを検証する
          expect(page).to have_content @item.name
          # 商品が1つになっていることを検証する
          expect(Item.count).to eq(1)
        end
      end

      context '商品詳細画面' do
        example 'ヘッダから商品一覧へのリンクを押下する=>商品一覧画面が表示される' do
          @item = create(:item)
          # 商品詳細画面画面を開く
          visit admins_item_path(@item)
          # 商品一覧をクリックする
          click_on '商品一覧'
          # 商品一覧画面表示に成功したことを検証する
          expect(page).to have_content '商品一覧'
          expect(Item.count).to eq(1)
        end
      end

      context '商品一覧画面' do
        before do
          @item1 = create(:item)
        end

        example '登録した商品が表示されている' do
          # 商品一覧画面を開く
          visit admins_items_path
          # 商品一覧画面表示に成功したことを検証する
          expect(page).to have_content @item1.name
        end

        example '新規登録ボタンを押下する(2商品目)=>商品新規登録画面が表示される' do
          @item2 = build(:item)
          @genre = create(:genre)
          # 商品新規登録画面を開く
          visit new_admins_item_path
          # 商品新規登録画面表示に成功したことを検証する
          expect(page).to have_content '商品新規登録'
          # フォームに値を入力する
          fill_in 'item_name', with: @item2.name
          fill_in 'item_explanation', with: @item2.explanation
          fill_in 'item_price', with: @item2.price
          # セレクトボックスで値を指定する
          select @genre.name, from: 'item_genre_id'
          select @item2.is_valid, from: 'item_is_valid'
          # 画像ファイルを指定する
          attach_file 'item_image', "#{Rails.root}/spec/factories/rails.png"
          # 新規登録ボタンをクリックする
          click_button '新規登録'
          # 商品新規登録画面表示に成功したことを検証する
          expect(page).to have_content @item2.name
          # 商品が2つになっていることを検証する
          expect(Item.count).to eq(2)
        end
      end
    end
  end
end
