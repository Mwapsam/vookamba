class User < ApplicationRecord
  has_one :review
  has_many :categories
  has_many :packages
  has_many :messages

  has_many :notifications, as: :recipient, dependent: :destroy

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :username, presence: true, length: { maximum: 250 }
end
