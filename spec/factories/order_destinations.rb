FactoryBot.define do
  factory :order_destination do
    post_code { '123-4567' }
    sender_id { 2 }
    city { '市区町村' }
    block { '1-1' }
    building { '建物名1' }
    phone_number { 12345678910 }
    token {"tok_abcdefghijk00000000000000000"}

  end
end
