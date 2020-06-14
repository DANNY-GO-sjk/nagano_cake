class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :order_params, only: [:create, :confirm]

  def index
    @orders = current_user.orders
  end

  def new
    @cart_items = current_user.cart_items
    if @cart_items.ids.blank?
      redirect_to cart_items_path, alert: 'カートに商品を入れてください'
    end
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
    if params[:s_address] == "r1"
      @order.postcode = current_user.postcode
      @order.address = current_user.address
      @order.receiver = current_user.full_name
    elsif params[:s_address] == "r2" && params[:shipping_address].present?
      s_address = ShippingAddress.find(shipping_address_params[:id])
      @order.postcode = s_address.postcode
      @order.address = s_address.address
      @order.receiver = s_address.receiver
    elsif params[:s_address] == "r3" && has_correct_address?
      @order.postcode = params[:r3_postcode]
      @order.address = params[:r3_address]
      @order.receiver = params[:r3_receiver]
    else
      flash[:alert] = "不足している情報があります"
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

  def shipping_address_params
    params.require(:shipping_address).permit(:id)
  end

  def has_correct_address?
    return false if params[:r3_postcode].blank?
    return false if params[:r3_address].blank?
    return false if params[:r3_receiver].blank?
    true
  end
end
