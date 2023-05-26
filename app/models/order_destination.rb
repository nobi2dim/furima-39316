class OrderDestination
  include ActiveModel::Model
  attr_accessor :post_code, :sender_id, :city, :block, :building, :phone_number, :user_id, :item_id, :token

  with_options presence: true do
    validates :post_code, format: { with: /\A[0-9]{3}-[0-9]{4}\z/, message: 'が無効です。 ハイフン(-)を入れて入力してください' }
    validates :city
    validates :block
    validates :phone_number, format: { with: /\A\d{10}\z|\A\d{11}\z/, message: 'が無効です' }
    validates :user_id
    validates :item_id
    validates :token
  end
  validates :sender_id, numericality: { other_than: 1, message: "を選択してください" }

  def save
    order = Order.create(user_id: user_id, item_id: item_id)
    Destination.create(post_code: post_code, sender_id: sender_id, city: city, block: block, building: building,
                       phone_number: phone_number, order_id: order.id)
  end
end
