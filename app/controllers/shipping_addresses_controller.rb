class ShippingAddressesController < ApplicationController
  def index
    @shipping_address = ShippingAddress.new
    @shipping_addresses = current_user.shipping_addresses
  end

  def create
    @shipping_address = ShippingAddress.new(shipping_address_params)
    @shipping_address.user_id = current_user.id # 配送先に配送先に会員idを登録
    if @shipping_address.save
      redirect_to shipping_addresses_path, notice: '配送先情報を登録しました'
    else
      flash[:alert] = "入力されていない箇所があります"
      render 'index'
    end
  end

  def edit
    @shipping_address = ShippingAddress.find(params[:id])
  end

  def update
    @shipping_address = ShippingAddress.find(params[:id])
    @shipping_address.user_id = current_user.id
    if @shipping_address.update(shipping_address_params)
      redirect_to shipping_addresses_path, notice: '配送先情報を変更しました'
    else
      flash[:alert] = "入力されていない箇所があります"
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
