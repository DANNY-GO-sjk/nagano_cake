class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :cart_items, dependent: :destroy
  has_many :shipping_addresses, dependent: :destroy

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
end
