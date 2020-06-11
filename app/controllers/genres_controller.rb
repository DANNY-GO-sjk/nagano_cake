class GenresController < ApplicationController
  before_action :authenticate_user!

  def search
    @genres = Genre.where(is_valid: true)
    @genre = Genre.find(params[:id])
    @items = @genre.items.all.page(params[:page]).per(8)
    render 'items/index'
  end
end
