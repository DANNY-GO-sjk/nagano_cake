class Admins::OrderItemsController < ApplicationController
  def update
    @order_item = Order_item.find(params[:id])
    @order_item.update
    redirect_to admins_order_path(@order.id)
  end
end
