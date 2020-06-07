class HomeController < ApplicationController
  def index
    @genres = Genre.where(is_valid: true)
    # @items = Item.おすすめ商品
  end
end
