class GenresController < ApplicationController
  def index
    @genres = Genre.where(is_valid: true)
    # ジャンルステータスが有効なものだけ表示
    if params[:genre_id]
      @genre = Genre.find(params[:genre_id])
      @items =Item.where(genre_id: params[:genre_id]).page(params[:page])
    end
  end
end
