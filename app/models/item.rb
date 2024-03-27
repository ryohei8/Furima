class Item < ApplicationRecord
  belongs_to :user
  has_one :purchase_record
  has_one_attached :image

  validates :category_id, :condition_id, :shipping_cost_burden_id, :province_id, :shipping_day_id,
            numericality: { other_than: 1, message: "can't be blank" }
end
