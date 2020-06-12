class Admins::UsersController < ApplicationController
  before_action :authenticate_admin!

  def index
    @users = User.search(params[:str])
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to admins_user_path(@user)
    else
      render 'edit'
    end
  end

  def edit_withdraw
    @user = @user = User.find(params[:id])
  end

  def withdraw
    @user = @user = User.find(params[:id])
    @user.update(is_valid: true) # 会員ステータスの退会を有効にする
    @end_user.destroy
    redirect_to root_path
  end

  private

  def user_params
    params.require(:user).permit(
      :family_name,
      :first_name,
      :family_name_yomi,
      :first_name_yomi,
      :postcode,
      :address,
      :phone_number,
      :is_valid
    )
  end
end
