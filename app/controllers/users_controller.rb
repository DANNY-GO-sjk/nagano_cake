class UsersController < ApplicationController
  def show
    @user = current_user
  end

<<<<<<< HEAD
=======
  def edit_info
    @user = current_user
  end

>>>>>>> cbb09bc25462ce6cc41e9ecb1f9363048081e603
  def update
    user = current_user
    if user.update(user_params)
      redirect_to users_path(user)
    else
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
