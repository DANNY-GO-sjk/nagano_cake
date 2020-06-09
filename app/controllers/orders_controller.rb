class OrdersController < ApplicationController
  before_action :order_params, only: [:create, :confirm]

  def index
    @orders = current_user.orders
  end

  def new
    @order = Order.new
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
      render :complete
    else
    end
  end

  def show
    @order = Order.find(params[:id])
  end

  def confirm
    @order = Order.new(order_params)
    if request.post?
      if params[:s_address] == "r1"
        @postcode = current_user.postcode
        @address = current_user.address
        @receiver = current_user.family_name + current_user.first_name
      elsif params[:s_address] == "r2"
        adr = ShippingAddress.find(params[:order][:r2_address])
        @postcode = adr.postcode
        @address = adr.address
        @receiver = adr.receiver
      else
        @postcode = params[:order][:r3_postcode]
        @address = params[:order][:r3_address]
        @receiver = params[:order][:r3_receiver]
      end
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
      :receiver
    )
  end
end
