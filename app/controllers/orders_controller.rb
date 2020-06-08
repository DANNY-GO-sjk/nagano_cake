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
      redirect_to home_path # FIX: 本当はサンクスページ
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
        @receiver = (current_user.family_name + current_user.first_name)
      elsif params[:s_address] == "r2"
        s_address = ShippingAddress.find(params[:r2_address])
        @postcode = s_address.postcode
        @address = s_address.address
        @receiver = s_address.receiver
      else
        @postcode = r3_postcode
        @address = r3_address
        @receiver = r3_receiver
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
