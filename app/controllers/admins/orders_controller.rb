class Admins::OrdersController < ApplicationController
  before_action :authenticate_admin!

  def index
    @orders = Order.all
  end

  def show
    @order = Order.find(params[:id])
  end

  def update
    @order = Order.find(params[:id])
    if params[:order][:progress] == '入金確認'
      order_items = @order.order_items
      order_items.each do |order_item|
        OrderItem.update(progress: "製作待ち")
      end
    end
    @order.update(order_params)
    flash[:notice] = "注文ステータスを変更しました"
    redirect_to admins_order_path(@order.id)
  end

  private

  def order_params
    params.require(:order).permit(:user_id, :postcode, :payment_method, :progress, :address)
  end
end
