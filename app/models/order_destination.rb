class OrderDestination
  include ActiveModel::Model
  attr_accessor :post_code, :sender_id, :city, :block, :building, :phone_number, :user_id, :item_id

  with_options presence: true do
    validates :post_code, format: {with: /\A[0-9]{3}-[0-9]{4}\z/, message: "is invalid. Include hyphen(-)"}
    validates :city, format: { with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/ }
    validates :block
    validates :phone_number, format: {with: /\A\d{10}\z|\A\d{11}\z/ , message: "is invalid."}
    validates :user_id
    validates :item_id
  end
  validates :sender_id, numericality: {other_than: 0, message: "can't be blank"}
  validates :building

  def save
    order = Order.create(user_id: user_id, item_id: item_id)
    Destination.create(post_code: post_code, sender_id: sender_id, city: city, block: block, building: building, phone_number: phone_number)
  end
end