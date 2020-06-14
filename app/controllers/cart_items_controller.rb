class CartItemsController < ApplicationController
  before_action :authenticate_user!
  before_action :cart_item_params, only: [:update]

  def index
    @cart_items = current_user.cart_items
  end

  def create
    @cart_item = CartItem.new(cart_item_params)
    @cart_item.user_id = current_user.id
    if @cart_item.save
      redirect_to cart_items_path, notice: '商品をカートに入れました'
    else
      @item = Item.find(params[:cart_item][:item_id])
      redirect_to item_path(@item.id), alert: '個数を指定してください'
    end
  end

  def update
    cart_item = CartItem.find(params[:id])
    cart_item.update(cart_item_params)
    redirect_to cart_items_path
  end

  def destroy
    cart_item = CartItem.find(params[:id])
    cart_item.destroy
    redirect_to cart_items_path, notice: 'カートから商品を削除しました'
  end

  def destroy_all
    current_user.cart_items.destroy_all
    redirect_to cart_items_path, notice: 'カートから商品を全て削除しました'
  end

  private

  def cart_item_params
    params.require(:cart_item).permit(:item_id, :user_id, :how_many)
  end
end
