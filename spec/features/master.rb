require 'rails_helper'

RSpec.describe "マスタ登録", type: :feature do
  before do
    # 管理者を作成する
    Admin.create!(email: 'foo@example.com', password: '123456')
  end

  example '管理者' do
    # 管理者用ログインページを開く
    visit new_admin_session_path
    # メールアドレス・パスワードでログインする
    fill_in 'admin_email', with: 'foo@example.com'
    fill_in 'admin_password', with: '123456'
    # ログインボタンをクリックする
    click_button 'ログイン'
    # 管理者トップ画面が表示される
    expect(page).to have_content '管理者画面'

    # ヘッダからジャンル一覧へのリンクを押下する
    click_on 'ジャンル一覧'
    # ジャンル一覧画面が表示される
    expect(page).to have_content 'ジャンル一覧・追加'

    # 必要事項を入力し、登録ボタンを押下する
    @genre = build(:genre)
    # フォームにnameを入力する
    fill_in 'genre_name', with: @genre.name
    # 有効ボタンにチェックする
    choose 'genre_is_valid_有効'
    click_button '追加'
    # 登録に成功したことを検証する
    expect(Genre.count).to eq(1)
    # 追加したジャンルが表示されている
    expect(page).to have_content @genre.name

    # ヘッダから商品一覧へのリンクを押下する
    click_on '商品一覧'
    # 商品一覧画面が表示される
    expect(page).to have_content '商品一覧'

    # 新規登録ボタンを押下する
    click_on '+' # FIX ME: 本当はIDとかで管理したい
    # 商品新規登録画面が表示される
    expect(page).to have_content '商品新規登録'

    # 必要事項を入力して登録ボタンを押下する
    @item1 = build(:item)
    # フォームに値を入力する
    fill_in 'item_name', with: @item1.name
    fill_in 'item_explanation', with: @item1.explanation
    fill_in 'item_price', with: @item1.price
    # セレクトボックスで値を指定する
    select @genre.name, from: 'item_genre_id'
    select @item1.is_valid, from: 'item_is_valid'
    # 画像ファイルを指定する
    attach_file 'item_image', "#{Rails.root}/spec/factories/rails.png"
    # 新規登録ボタンをクリックする
    click_button '新規登録'
    # 登録した商品の詳細画面に遷移する
    expect(page).to have_content @item1.name
    # 商品が1つになっていることを検証する
    expect(Item.count).to eq(1)

    # ヘッダから商品一覧へのリンクを押下する
    click_on '商品一覧'
    # 商品一覧画面が表示される
    expect(page).to have_content '商品一覧'

    # 商品一覧画面が表示される
    expect(page).to have_content @item1.name

    # 新規登録ボタンを押下する(2商品目)
    click_on '+' # FIX ME: 本当はIDとかで管理したい
    # 商品新規登録画面が表示される
    expect(page).to have_content '商品新規登録'

    # 必要事項を入力して登録ボタンを押下する
    @item2 = build(:item)
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
    # 登録した商品の詳細画面に遷移する
    expect(page).to have_content @item2.name
    # ジャンルの商品が2つになっていることを検証する
    expect(Item.count).to eq(2)

    # ヘッダから商品一覧へのリンクを押下する
    click_on '商品一覧'
    # 商品一覧画面が表示される
    expect(page).to have_content '商品一覧'

    # 登録した商品が表示されている
    expect(page).to have_content @item2.name

    # ヘッダからログアウトボタンをクリックする
    click_on 'ログアウト'
    # 管理者ログイン画面に遷移する
    expect(page).to have_content '管理者ログイン'
  end
end
