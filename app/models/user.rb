class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :nickname, presence: true
  validates :first_name,
            format: { with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/ },
            presence: true
  validates :last_name,
            format: { with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/ },
            presence: true
  validates :first_name_kana,
            format: { with: /\A([ァ-ン]|ー)+\z/ },
            presence: true
  validates :last_name_kana,
            format: { with: /\A([ァ-ン]|ー)+\z/ },
            presence: true
  validates :birth_date, presence: true

  VALID_PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i.freeze
  validates :password, format: { with: VALID_PASSWORD_REGEX }

  has_many :items
  has_many :orders
end
