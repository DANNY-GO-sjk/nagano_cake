class Admins::ItemsController < ApplicationController
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

	private

	def item_params
		params.require(:item).permit(:genre_id, :name, :price, :image, :explanation, :is_valid)
	end
end
