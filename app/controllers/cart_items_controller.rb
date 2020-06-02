class CartItemsController < ApplicationController
  def index
    @cart_items = current_user.cart_items
  end

  def destroy
    # 未実装
  end

  def destroy_all
    # 未実装
  end
end
