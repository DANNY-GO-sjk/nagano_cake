class HomeController < ApplicationController
  def index
    @genres = Genre.where(is_valid: true)
    @items = Item.order(recommended: "DESC").limit(4)
  end

  def about
  end
end
