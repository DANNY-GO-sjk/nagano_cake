class Admins::OrderItemsController < ApplicationController
  before_action :authenticate_admin!

  def update
    @order_item = OrderItem.find(params[:id])
    @order_item.update(order_item_params)
    @order = @order_item.order
    if params[:order_item][:progress] == "製作中"
      @order.update(progress: "製作中")
    end
    if params[:order_item][:progress] == "製作完了" && all_items_progress?
      @order.update(progress: "発送準備中")
    end
    redirect_to admins_order_path(@order.id)
  end

  def all_items_progress?
    @order.order_items.each do |o|
      return false if o.progress != "製作完了"
    end
  end

  private

  def order_item_params
    params.require(:order_item).permit(:order_id, :item_id, :how_many, :price, :progress)
  end
end
