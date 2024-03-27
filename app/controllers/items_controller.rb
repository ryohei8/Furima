class ItemsController < ApplicationController
  def index
  end

  def new
  end

  def create
  end

  private

  def item_paramas
    params.require(:item).permit(:name, :description, :category_id, :condition_id, :shipping_cost_burden_id, :province_id,
                                 :shipping_day_id, :price, :image).merge(user_id: current_user.id)
  end
end
