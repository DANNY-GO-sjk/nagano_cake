class Admins::HomeController < ApplicationController
  def index
    @orders = Order.all # １日の注文数ですが、未実装です。一時的に全件取得しています。
  end
end
