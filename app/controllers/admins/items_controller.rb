class Admin::ItemsController < ApplicationController
	def index
		@items = Item.page(params[:page])
	end

	def new
		@item = Item.new
	end

	def create
	end
end
