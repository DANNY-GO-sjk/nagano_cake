class GenresController < ApplicationController
  def search
    # is_validがマッチするレコードを全て取得
    @genres = Genre.where(is_valid: true)
    @genre = Genre.find(params[:id])
    @items = @genre.items.all.page(params[:page]).per(8)
    render 'items/index'
  end
end
