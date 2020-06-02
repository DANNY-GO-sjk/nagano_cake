class Admins::HomeController < ApplicationController
	def index
		@orders = Orders.count#１日の注文数
	end
end
