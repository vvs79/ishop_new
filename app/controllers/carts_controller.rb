class CartsController < ApplicationController
  before_filter :authenticate_user!, only: [:show, :index]

  def index
  	@carts_count = user_signed_in? ? current_user.carts.where("order_id IS ?", nil).count : 0
    @carts = current_user.carts.where("order_id IS ?", nil)
    @carts = @carts.paginate(page: params[:page] || 1, per_page: 10).order(id: :desc)
  end

  def destroy
    @cart = current_user.carts.find(params[:id])
    @cart.item.increment!(:quantity)
    @cart.destroy
    redirect_to :back
  end

end
