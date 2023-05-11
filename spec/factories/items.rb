FactoryBot.define do
  factory :item do
    name         { 'Test' }
    detail       { 'テスト用の商品説明' }
    postage_id   { 2 }
    price        { 1000 }
    shipment_id  { 2 }
    category_id  { 2 }
    sender_id    { 2 }
    condition_id { 2 }
    association :user

    after(:build) do |item|
      item.image.attach(io: File.open('app/assets/images/test.png'), filename: 'test.png')
    end
  end
end
