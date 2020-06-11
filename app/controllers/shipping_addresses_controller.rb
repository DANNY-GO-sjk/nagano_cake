class ShippingAddressesController < ApplicationController
  before_action :authenticate_user!

  def index
    @shipping_address = ShippingAddress.new
    @shipping_addresses = current_user.shipping_addresses
  end

  def create
    @shipping_address = ShippingAddress.new(shipping_address_params)
    @shipping_address.user_id = current_user.id # 配送先に配送先に会員idを登録
    @shipping_address.save
    redirect_to shipping_addresses_path
  end

  def edit
    @shipping_address = ShippingAddress.find(params[:id])
  end

  def update
    @shipping_address = ShippingAddress.find(params[:id])
    @shipping_address.user_id = current_user.id
    if @shipping_address.update(shipping_address_params)
      redirect_to shipping_addresses_path
    else
      render 'edit'
    end
  end

  def destroy
    @shipping_address = ShippingAddress.find(params[:id])
    @shipping_address.destroy
    redirect_to shipping_addresses_path
  end

  private

  def shipping_address_params
    params.require(:shipping_address).permit(:postcode, :address, :receiver)
  end
end
