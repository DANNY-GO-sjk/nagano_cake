class Admin::ItemsController < ApplicationController
	def index
		@items = Item.page(params[:page])
	end

	def new
		@item = Item.new
	end

	def create
		@item = Item.new(item_params)
		if @item.save
			flash[:notice] = "商品登録が完了しました"
			redirect_to admins_items_path
		else
			@item = Item.new
			render :new
		end
	end
end
