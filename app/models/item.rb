class Item < ApplicationRecord
  belongs_to :user
  has_one_attached :image

  validates :name, presence: true
  validates :detail, presence: true
  validates :price, format: { with: /\A[0-9]+\z/ },
            numericality: { greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999 }
  validates :image, presence: true

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :condition
  belongs_to :postage
  belongs_to :sender
  belongs_to :shipment

  validates :category_id, numericality: { other_than: 1 , message: "can't be blank" }
  validates :condition_id, numericality: { other_than: 1 , message: "can't be blank" }
  validates :postage_id, numericality: { other_than: 1 , message: "can't be blank" }
  validates :sender_id, numericality: { other_than: 1 , message: "can't be blank" }
  validates :shipment_id, numericality: { other_than: 1 , message: "can't be blank" }
end
