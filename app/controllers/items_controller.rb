class ItemsController < ApplicationController
  def index
    # is_validがマッチするレコードを全て取得
    @genres = Genre.where(is_valid:true)
    if params[:genre_id]
      # genreのデータベースのテーブルから一致するidを取得
      @genre = Genre.find(params[:genre_id])
      #genre_idと紐ずく商品を取得(ジャンル)(8個取得)
      @items = @genre.items.all.page(params[:page]).per(8)
    else
      # 商品全てを取得
      @items =Item.page(params[:page]).per(8)
    end
  end

  def show
    @genres = Genre.where(is_valid: true)
    @item = Item.find(params[:id])
  end
end
