require 'rails_helper'

RSpec.describe Order, type: :model do
  before do
    user = FactoryBot.create(:user)
    item = FactoryBot.create(:item)
    @order = FactoryBot.build(:order, user_id: user.id, item_id: item.id)
  end
  describe '商品の購入' do
    context '商品が購入できる' do
      it 'すべての項目が存在すれば登録できる' do
        expect(@order).to be_valid
      end

      it 'bulding_nameが空でも登録できる' do
        @order.building_name = ''
        expect(@order).to be_valid
      end
    end
    context '商品が購入できない' do
      it 'tokenが空では購入できない' do
        @order.token = ''
        @order.valid?
        expect(@order.errors.full_messages).to include("Token can't be blank")
      end

      it 'postal_codeが空では購入できない' do
        @order.postal_code = ''
        @order.valid?
        expect(@order.errors.full_messages).to include("Postal code can't be blank")
      end

      it 'postal_codeを-(ハイフン)を含めて入力しないと購入できない' do
        @order.postal_code = '1234567'
        @order.valid?
        expect(@order.errors.full_messages).to include('Postal code is invalid. Include hyphen(-)')
      end

      it 'posta_codeが半角整数じゃなければ購入できない' do
        @order.postal_code = 'テスト'
        @order.valid?
        expect(@order.errors.full_messages).to include('Postal code is invalid. Include hyphen(-)')
      end

      it 'posta_codeが数字3文字 -(ハイフン) 数字4文字じゃないと購入できない' do
        @order.postal_code = '123-45678'
        @order.valid?
        expect(@order.errors.full_messages).to include('Postal code is invalid. Include hyphen(-)')
      end

      it 'phone_numberが空では購入できない' do
        @order.phone_number = ''
        @order.valid?
        expect(@order.errors.full_messages).to include("Phone number can't be blank")
      end

      it 'phone_numberが12桁以上場合に購入できない' do
        @order.phone_number = '123456789012'
        @order.valid?
        expect(@order.errors.full_messages).to include('Phone number is invalid')
      end

      it 'phone_numberが9桁以下の場合に購入できない' do
        @order.phone_number = '123456789'
        @order.valid?
        expect(@order.errors.full_messages).to include('Phone number is invalid')
      end

      it 'phone_numberが半角数値でないと購入できない' do
        @order.phone_number = 'テスト'
        @order.valid?
        expect(@order.errors.full_messages).to include('Phone number is invalid')
      end

      it 'cityが空では購入できない' do
        @order.city = ''
        @order.valid?
        expect(@order.errors.full_messages).to include("City can't be blank")
      end

      it 'street_addressが空では購入できない' do
        @order.street_address = ''
        @order.valid?
        expect(@order.errors.full_messages).to include("Street address can't be blank")
      end

      it 'user_idが空では購入できない' do
        @order.user_id = nil
        @order.valid?
        expect(@order.errors.full_messages).to include("User can't be blank")
      end

      it 'item_idが空では購入できない' do
        @order.item_id = nil
        @order.valid?
        expect(@order.errors.full_messages).to include("Item can't be blank")
      end

      it 'province_idが空では購入できない' do
        @order.province_id = 1
        @order.valid?
        expect(@order.errors.full_messages).to include("Province can't be blank")
      end
    end
  end
end
