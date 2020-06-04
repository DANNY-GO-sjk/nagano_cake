class Admin::ItemsController < ApplicationController
	def index
  	 # ジャンル一覧未実装
  	@items =Item.page(params[:page])
  end

  def show
  	@items = Item.find(params[:id])
  end
end
