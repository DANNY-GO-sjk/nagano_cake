class Admins::SearchesController < ApplicationController
  before_action :authenticate_admin!

  def search
    case params[:category]
    when "items"
      redirect_to admins_items_path(str: params[:str])
    when "users"
      redirect_to admins_users_path(str: params[:str])
    else
    end
  end
end
