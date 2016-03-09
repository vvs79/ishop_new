include ActionView::Helpers::TextHelper

class ItemsController < ApplicationController
  before_filter :authenticate_user!, only: [:show, :expensive, :sell]
  before_filter :check_if_admin, only: [:edit, :update, :destroy, :create, :new]

  def index
    @carts_count = user_signed_in? ? current_user.carts.where("order_id IS ?", nil).count : 0
    @items = Item.all
    @items = @items.where("quantity > ?", 0)
    @search = @items.search(params[:q] || {})
    @items = @search.result.paginate(page: params[:page] || 1, per_page: 10).order(id: :desc)
  end

  def show
    @item = Item.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    flash[:danger] = 'Item does not exist!'
    redirect_to items_path
  end

  def edit
    @item = Item.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    flash[:danger] = 'Item does not exist!'
    redirect_to items_path
  end

  def update
    @item = Item.find(params[:id])
    if @item.update_attributes(item_params)
      flash[:success] = 'Item updated'
      redirect_to item_path(@item)
    else
      render 'edit'
    end
  end

  def new
    @item = current_user.items.new
  end

  def create
    @item = current_user.items.new(item_params)
    if @item.save
      redirect_to item_path(@item)
    else
      render 'new'
    end
  end

  def destroy
    Item.find(params[:id]).destroy
    redirect_to :back
  end

  def sell
    @item = Item.find(params[:id])
    if @item.quantity > 0
      @item.decrement!(:quantity)
      @item.cart_id = current_user.carts.create(quantity: 1).id
      redirect_to items_path
    else
      render 'index'
    end
  end

  def expensive
    @items = Item.where("price > 1000")
    render 'index'
  end

  private

    def item_params
      params.require(:item).permit(:name, :price, :description, :kind, {images: []})
    end

end
