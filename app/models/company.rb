class Company < ApplicationRecord
    has_many :reviews
    belongs_to :business
    belongs_to :category, class_name: 'Category', foreign_key: 'category_id'
    has_one_attached :image
end
