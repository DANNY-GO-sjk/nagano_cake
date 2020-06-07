class OrdersController < ApplicationController
  before_action :order_params, only: [:create, :confirm]
  before_action :shipping_address_params, only: [:confirm]

  def index
    @orders = current_user.orders
  end

  def new
    @order = Order.new
    @shipping_address = ShippingAddress.new
  end

  def create
    order = Order.new(order_params)
    order.user_id = current_user.id
    if order.save
      current_user.cart_items.each do |cart_item|
        OrderItem.create(
          order_id: order.id,
          item_id: cart_item.item.id,
          how_many: cart_item.how_many,
          price: cart_item.item.price
        )
        cart_item.destroy
      end
      redirect_to home_path # FIX: 本当はサンクスページ
    else
    end
  end

  def show
    @order = Order.find(params[:id])
  end

  def confirm
    @order = Order.new(order_params)
    @shipping_address = ShippingAddress.new(shipping_address_params)
    if @order.has_shipping_address?
    else
      render :new
    end
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
      :receiver,
      :shipping_address[
        :postcode,
        :address,
        :receiver
      ]
    )
  end

  def shipping_address_params
    params.require(:shipping_address).permit([
      :id,
      :postcode,
      :address,
      :receiver,
    ])
  end
end
