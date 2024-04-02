class OrdersController < ApplicationController
  before_action :move_to_index, only: [:index]
  def index
    @order = Order.new
    @item = Item.find(params[:item_id])
  end

  def create
    @item = Item.find(params[:item_id])# ネストしてて親の情報欲しかったらitem_id、子だったら[:id]
    @order = Order.new(order_params)
    if @order.valid?
      pay_item
      @order.save
      redirect_to root_path
    else
      render :index, status: :unprocessable_entity
    end
  end

  private

  def order_params
    params.require(:order).permit(:postal_code, :province_id, :city, :street_address, :building_name, :phone_number
                                  ).merge(user_id: current_user.id, item_id: @item.id, token: params[:token])
  end

  def move_to_index
    if current_user.nil?
      redirect_to root_path
      return
    end

    @item = Item.find(params[:item_id])
    if @item.purchase_record.present? || current_user.id == @item.user_id
      redirect_to root_path
    end
  end

  def pay_item
    Payjp.api_key = 'sk_test_2ccd987ca658610d0c02666c'
    Payjp::Charge.create(
      amount: @item.price,
      card: order_params[:token],
      currency: 'jpy'
    )
  end
end
