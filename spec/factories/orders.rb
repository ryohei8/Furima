FactoryBot.define do
  factory :order do
    token { 'sk_test_2ccd987ca000000d0c33333c' }
    postal_code { '123-4567' }
    province_id { 2 }
    city { '横浜市緑区' }
    street_address { '青山1-1-1' }
    building_name { 'テストビル' }
    phone_number { '09012345678' }
    user_id { 1 }
    item_id { 1 }
  end
end
