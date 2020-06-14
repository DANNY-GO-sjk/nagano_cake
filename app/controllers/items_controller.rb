class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:show]

  def index
    # is_validがマッチするレコードを全て取得
    @genres = Genre.where(is_valid: true)
    # 商品全てを取得
    @items = Item.page(params[:page]).per(8)
    @title = '商品'
  end

  def show
    @genres = Genre.where(is_valid: true)
    @item = Item.find(params[:id])
    @cart_item = CartItem.new
  end
end
