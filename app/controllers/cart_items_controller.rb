class CartItemsController < ApplicationController
  def index
    @cart_items = current_user.cart_items
  end

  def create
    # FIX: 問答無用で商品の一番をカートに追加している
    # 本当は 商品詳細画面からitem_id を受け取る。
    current_user.cart_items.create(item_id: 1)
    redirect_to cart_items_path
  end

  def destroy
    cart_item = CartItem.find(params[:id])
    cart_item.destroy
    redirect_to cart_items_path
  end

  def destroy_all
    current_user.cart_items.destroy_all
    redirect_to cart_items_path
  end
end
