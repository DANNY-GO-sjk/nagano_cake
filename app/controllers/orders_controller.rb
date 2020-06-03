class OrdersController < ApplicationController
  before_action :order_params, only: [:create, :confirm]

  def index
    @orders = current_user.orders
  end

  def new
    @order = Order.new
  end

  def create
    current_user.orders.create(order_params)
    redirect_to home_path # FIX: 本当はサンクスページ
  end

  def show
  end

  def confirm
    @order = Order.new(order_params)
  end

  def back
  end

  private

  def order_params
    params.require(:order).permit(
      :total_price,
      :payment_method,
      :postcode,
      :address,
      :receiver
    )
  end
end
