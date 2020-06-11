class Admins::OrdersController < ApplicationController
  def index
    @orders = Order.all
  end

  def show
    @order = Order.find(params[:id])
  end

  def update
    @order = Order.find(params[:id])
    @order.update(order_params)
    redirect_to admins_order_path(@order.id)
  end

  private

  def order_params
    params.require(:order).permit(:user_id, :postcode, :payment_method, :progress, :address)
  end
end
