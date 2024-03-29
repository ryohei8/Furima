class Item < ApplicationRecord
  belongs_to :user
  # has_one :purchase_record
  has_one_attached :image

  validates :image, :name, :description, presence: true

  validates :price, format: { with: /\A[0-9]+\z/ },
                    numericality: { only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999 }

  validates :category_id, :condition_id, :shipping_cost_burden_id, :province_id, :shipping_day_id,
            numericality: { other_than: 1, message: "can't be blank" }
end
