class Admins::ItemsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @items = Item.page(params[:page]).search(params[:str])
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
      flash[:alert] = "入力されていない箇所があります"
      render 'new'
    end
  end

  def show
    @item = Item.find(params[:id])
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])
    if @item.update(item_params)
      flash[:notice] = "編集を保存しました"
      redirect_to admins_item_path(@item.id)
    else
      flash[:alert] = "入力されていない箇所があります"
      render 'edit'
    end
  end

  private

  def item_params
    params.require(:item).permit(:genre_id, :name, :price, :image, :explanation, :is_valid, :recommended)
  end
end
