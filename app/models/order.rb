class Order
  include ActiveModel::Model
  attr_accessor :postal_code, :province_id, :city, :street_address, :building_name, :phone_number, :purchase_record_id, :user_id,
                :item_id, :token, :image

  with_options presence: true do
    validates :postal_code, format: { with: /\A[0-9]{3}-[0-9]{4}\z/, message: 'is invalid. Include hyphen(-)' }
    validates :phone_number, format: { with: /\A\d{10,11}\z/, message: 'is invalid' }
    validates :city, :street_address, :user_id, :item_id, :token
    validates :province_id, numericality: { other_than: 1, message: "can't be blank" }
  end

  def save
    purchase_record = PurchaseRecord.create(user_id:, item_id:)
    ShippingAddress.create(postal_code:, province_id:, city:, street_address:, building_name:, phone_number:,
                           purchase_record_id: purchase_record.id)
  end
end
