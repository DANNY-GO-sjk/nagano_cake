class UsersController < ApplicationController
  def show
    @user = current_user
  end

  def edit
    @user = User.find(current_user.id)
    # 本当はdeviseのビューで行う機能は後で行う
    # deviseコントローラーを使用
  end

  def update
    @user = User.find(current_user.id)
    if @user.update(user_params)
      redirect_to users_path(@user)
    else
      render 'edit'
    end
  end

  def edit_withdraw
    @user = current_user
  end

  def withdraw
    @user = User.find(current_user.id)
    @user.update(is_valid: false) #会員ステータスの退会を有効にする
    reset_session #情報をリセットする
    redirect_to home_path
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
