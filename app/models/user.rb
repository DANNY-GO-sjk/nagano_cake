class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :cart_items, dependent: :destroy
  has_many :orders, dependent: :destroy
  has_many :shipping_addresses, dependent: :destroy


  enum is_valid: { 無効: false, 有効: true }

  validates :first_name, presence: true
  validates :family_name, presence: true
  validates :family_name_yomi, presence: true
  validates :first_name_yomi, presence: true
  validates :email, presence: true
  validates :postcode, presence: true
  validates :address, presence: true
  validates :encrypted_password, presence: true
  validates :phone_number, presence: true
  validates :is_valid, presence: true

  # ログイン時に退会済みのユーザーが入れなくする
  def active_for_authentication?
    super && (is_valid == '有効')
  end
end
