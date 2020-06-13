class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = current_user
  end

  def edit_info
    @user = current_user
  end

  def update
    user = current_user
    if user.update(user_params)
      redirect_to users_path(user), notice: '登録情報を変更しました'
    else
      flash[:alert] = "入力されていない箇所があります"
      render 'edit'
    end
  end

  def edit_withdraw
    @user = current_user
  end

  def withdraw
    user = current_user
    user.update(is_valid: "無効")
    reset_session # 情報をリセットする
    redirect_to home_path, notice: '退会しました'
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
