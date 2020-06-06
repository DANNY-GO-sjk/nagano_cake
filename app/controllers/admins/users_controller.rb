class Admins::UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = current_user
  end

  def edit
    @user = User.find(current_user.id)
  end

  def update
    @user = User.find(current_user.id)
    if @user.update(user_params)
      redirect_to users_path(@user)
    else
      render 'edit'
    end
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
