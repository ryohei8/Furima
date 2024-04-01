class OrdersController < ApplicationController
  def index
    @order = Order.new
  end

  def create
    @item = Item.find(params[:item_id])# ネストしてて親の情報欲しかったらitem_id、子だったら[:id]
    @order = Order.new(order_params)
    if @order.valid?
      @order.save
      redirect_to root_path
    else
      render :index, status: :unprocessable_entity
    end
  end

  private

  def order_params
    params.require(:order).permit(:postal_code, :province_id, :city, :street_address, :building_name, :phone_number, 
                                  ).merge(user_id: current_user.id, item_id: @item.id)
  end
end
