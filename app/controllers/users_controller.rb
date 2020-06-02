class UsersController < ApplicationController
	def show
	   @user = current_user
	end

	def edit
		@user = User.find(params[:id])
		#本当はdeviseのビューで行う機能は後で行う
		#deviseコントローラーを使用


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
