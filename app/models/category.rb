class Category < ApplicationRecord
  belongs_to :user
  has_many :companies
  has_one_attached :picture
end
