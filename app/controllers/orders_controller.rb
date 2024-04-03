class OrdersController < ApplicationController
  before_action :move_to_login, only: [:index]
  before_action :move_to_index, only: [:index, :create]
  def index
    gon.public_key = ENV['PAYJP_PUBLIC_KEY']
    @order = Order.new
  end

  def create
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

  def move_to_login
    if current_user.nil?
      redirect_to new_user_session_path
    end
  end

  def move_to_index
    @item = Item.find(params[:item_id])
    if @item.purchase_record.present? || current_user.id == @item.user_id
      redirect_to root_path
    end
  end

  def pay_item
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    Payjp::Charge.create(
      amount: @item.price,
      card: order_params[:token],
      currency: 'jpy'
    )
  end
end
