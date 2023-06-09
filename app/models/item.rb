class Item < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  has_one :order

  validates :name, presence: true, length: { maximum: 40 }
  validates :detail, presence: true, length: { maximum: 1000 }
  validates :price, presence: true,
                    numericality: { only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999 }
  validates :image, presence: true

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :condition
  belongs_to :postage
  belongs_to :sender
  belongs_to :shipment

  validates :category_id, numericality: { other_than: 1, message: "を選択してください" }
  validates :condition_id, numericality: { other_than: 1, message: "を選択してください" }
  validates :postage_id, numericality: { other_than: 1, message: "を選択してください" }
  validates :sender_id, numericality: { other_than: 1, message: "を選択してください" }
  validates :shipment_id, numericality: { other_than: 1, message: "を選択してください" }
end
