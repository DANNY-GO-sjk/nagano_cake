class HomeController < ApplicationController
  def index
    @genres = Genre.all
    # @items = Item.おすすめ商品
  end
end
