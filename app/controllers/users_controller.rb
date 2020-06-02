class UsersController < ApplicationController
	def show
	   @user = User.find(params[:id])
	end

	def edit
		@user = User.find(params[:id])
	end

	def update
		@user = User.find(params[:id])
		if @user.update(user_params)
			redirect_to user_path(@user)
		else
			render 'edit'
		end
	end


	private
	def user_params
		params.require(:user).permit(:family_name, :first_name, :family_name_yomi, :first_name_yomi, :postcode, :address, :phone_number, :is_valid)
	end

end
